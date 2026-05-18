import 'dart:async';
import 'package:socaloca/core/constants/app_strings.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/theme/app_colors.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Equivalent of Android's MapsActivity.
/// Auto-detects GPS, shows a full-screen Google Map, lets the user
/// tap anywhere to pick a location, then returns via context.pop():
///   {'placeName': String, 'placeLat': double, 'placeLong': double}
class LocationPickerScreen extends StatefulWidget {
  LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final Completer<GoogleMapController> _mapController = Completer();

  static final _defaultLatLng = LatLng(20.5937, 78.9629); // center of India

  LatLng _markerPosition = _defaultLatLng;
  String _displayAddress = 'Detecting location...';
  bool _isGeocoding = false;
  bool _isLocating = true;
  bool _locationPermissionGranted = false;

  Set<Marker> get _markers => {
        Marker(
          markerId: MarkerId('selected'),
          position: _markerPosition,
          draggable: true,
          onDragEnd: _onMarkerDragEnd,
        ),
      };

  @override
  void initState() {
    super.initState();
    _detectCurrentLocation();
  }

  Future<void> _detectCurrentLocation() async {
    try {
      final granted = await _ensurePermission();
      setState(() => _locationPermissionGranted = granted);

      if (!granted) {
        setState(() {
          final _isLocating = false;
          final _displayAddress = 'Location permission denied';
        });
        return;
      }

      // Use .timeout() instead of LocationSettings.timeLimit so a timeout
      // always throws a catchable Dart exception (no native fatal on Android).
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      ).timeout(Duration(seconds: 15));

      final latLng = LatLng(position.latitude, position.longitude);
      await _moveToPosition(latLng);
    } catch (e) {
      if (mounted) {
        setState(() {
          final _isLocating = false;
          final _displayAddress = 'Could not detect location';
        });
      }
    }
  }

  Future<bool> _ensurePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<void> _moveToPosition(LatLng latLng) async {
    setState(() {
      final _markerPosition = latLng;
      final _isLocating = false;
    });

    final controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(latLng, 15),
    );

    await _reverseGeocode(latLng);
  }

  Future<void> _reverseGeocode(LatLng latLng) async {
    setState(() => _isGeocoding = true);

    // 1. Try Nominatim (OpenStreetMap) — no API key, no app restrictions.
    final nominatimAddress = await _geocodeViaNominatim(latLng);
    if (nominatimAddress != null) {
      if (mounted) {
        setState(() {
          final _displayAddress = nominatimAddress;
          final _isGeocoding = false;
        });
      }
      return;
    }

    // 2. Fallback: Android native Geocoder via geocoding package.
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = <String>[
          if (p.street != null && p.street!.isNotEmpty) p.street!,
          if (p.subLocality != null && p.subLocality!.isNotEmpty)
            p.subLocality!,
          if (p.locality != null && p.locality!.isNotEmpty) p.locality!,
          if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty)
            p.administrativeArea!,
          if (p.country != null && p.country!.isNotEmpty) p.country!,
        ];
        if (mounted) {
          setState(() {
            final _displayAddress =
                parts.isNotEmpty ? parts.join(', ') : _coordFallback(latLng);
            final _isGeocoding = false;
          });
        }
        return;
      }
    } catch (_) {}

    // 3. Last resort: raw coordinates.
    if (mounted) {
      setState(() {
        final _displayAddress = _coordFallback(latLng);
        final _isGeocoding = false;
      });
    }
  }

  /// Calls Nominatim reverse-geocoding API. Returns null on any failure.
  Future<String?> _geocodeViaNominatim(LatLng latLng) async {
    try {
      final dio = Dio();
      final response = await dio
          .get(
            'https://nominatim.openstreetmap.org/reverse',
            queryParameters: {
              'format': 'json',
              'lat': latLng.latitude.toString(),
              'lon': latLng.longitude.toString(),
              'addressdetails': '1',
            },
            options: Options(
              headers: {
                'User-Agent': 'SocaLoca/1.0 (contact@socaloca.football)'
              },
              receiveTimeout: Duration(seconds: 10),
              sendTimeout: Duration(seconds: 10),
            ),
          )
          .timeout(Duration(seconds: 12));

      final data = response.data is String
          ? jsonDecode(response.data as String) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      final displayName = data['display_name'] as String?;
      if (displayName != null && displayName.isNotEmpty) {
        return displayName;
      }
    } catch (_) {}
    return null;
  }

  String _coordFallback(LatLng latLng) =>
      '${latLng.latitude.toStringAsFixed(5)}, ${latLng.longitude.toStringAsFixed(5)}';

  void _onMapTap(LatLng latLng) {
    _moveToPosition(latLng);
  }

  void _onMarkerDragEnd(LatLng latLng) {
    _moveToPosition(latLng);
  }

  void _selectLocation() {
    context.pop<Map<String, dynamic>>({
      'placeName': _displayAddress,
      'placeLat': _markerPosition.latitude,
      'placeLong': _markerPosition.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _defaultLatLng,
              zoom: 5,
            ),
            onMapCreated: _mapController.complete,
            markers: _markers,
            onTap: _onMapTap,
            myLocationEnabled: _locationPermissionGranted,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // Top search bar with back arrow + address
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Back arrow
                      IconButton(
                        icon:
                            Icon(Icons.arrow_back, color: AppColors.socaBlack),
                        onPressed: () => context.pop(),
                      ),
                      // Address text
                      Expanded(
                        child: _isLocating || _isGeocoding
                            ? Row(
                                children: [
                                  AppLoader(size: 24, centered: false),
                                  SizedBox(width: 8),
                                  Text(
                                    'Fetching location...'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                _displayAddress,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom "SELECT LOCATION" button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: (_isLocating || _isGeocoding) ? null : _selectLocation,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: (_isLocating || _isGeocoding)
                          ? AppColors.socaBlack.withValues(alpha: 0.5)
                          : AppColors.socaBlack,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'SELECT LOCATION'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.socaYellow,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
