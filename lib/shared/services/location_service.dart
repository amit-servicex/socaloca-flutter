import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/theme/app_colors.dart';

class CountryInfo {
  CountryInfo({
    required this.name,
    required this.phoneCode,
    required this.iso,
  });

  final String name;
  final String phoneCode;
  final String iso;
}

class LocationService {
  // Returns a CountryInfo when GPS successfully identifies the country,
  // or null when permission is denied / GPS fails.
  // The caller keeps its own default when null is returned.
  static Future<CountryInfo?> detectCountry(BuildContext context) async {
    log('LocationService: starting country detection');

    // Check if already granted — skip dialog if so.
    final status = await Permission.location.status;
    if (status.isGranted) {
      final gps = await _countryFromGps();
      log('LocationService: already-granted → GPS=${gps?.iso ?? 'null (keeping caller default)'}');
      return gps;
    }

    // Show the SocaLoca rationale dialog before the OS prompt.
    if (!context.mounted) return null;
    final proceed = await _showRationaleDialog(context);
    if (!proceed) {
      log('LocationService: user tapped Learn more — keeping caller default');
      return null;
    }

    final result = await Permission.location.request();
    if (!result.isGranted) {
      log('LocationService: permission denied — keeping caller default');
      return null;
    }

    final gps = await _countryFromGps();
    log('LocationService: GPS=${gps?.iso ?? 'null (keeping caller default)'}');
    return gps;
  }

  // Uses Geolocator to get position and maps it to a country.
  // Tries last-known position first (instant) before requesting a fresh fix.
  static Future<CountryInfo?> _countryFromGps() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('LocationService: location service disabled');
        return null;
      }

      // 1. Try cached last-known position — no GPS warm-up needed.
      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        log('LocationService: using last-known position lat=${position.latitude} lng=${position.longitude}');
        final country =
            _isoFromCoordinates(position.latitude, position.longitude);
        if (country != null) return country;
      }

      // 2. Request a fresh fix — use network-quality accuracy (faster than GPS).
      log('LocationService: requesting fresh position...');
      position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.lowest, // network/cell-tower — much faster
        ),
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          log('LocationService: getCurrentPosition timed out');
          throw Exception('location timeout');
        },
      );

      log('LocationService: fresh position lat=${position.latitude} lng=${position.longitude}');
      return _isoFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      log('LocationService: GPS error — $e');
      return null;
    }
  }

  // Shows the custom SocaLoca location permission rationale dialog.
  // Returns true if user pressed OK, false if dismissed or pressed Learn More.
  static Future<bool> _showRationaleDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 28, 24, 16),
              child: Text(
                'Location Permission'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'SocaLoca asks for your location access to align you with your '
                "country's Football Association. SocaLoca also uses your location "
                'to find your tournament location. Your location data is only used '
                'to help you navigate through your football journey and is not saved '
                'for any other purposes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.socaBlack,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 24),
            Divider(height: 1, color: Color(0xFFE0E0E0)),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14),
                          ),
                        ),
                      ),
                      child: Text(
                        'Learn more'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1, color: Color(0xFFE0E0E0)),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                      ),
                      child: Text(
                        'OK'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return result ?? false;
  }

  // Simple bounding-box lookup for major football countries.
  // Returns null if coordinates don't match any known region (caller falls back to locale).
  static CountryInfo? _isoFromCoordinates(double lat, double lng) {
    for (final entry in _boundingBoxes) {
      if (lat >= entry.minLat &&
          lat <= entry.maxLat &&
          lng >= entry.minLng &&
          lng <= entry.maxLng) {
        return _countryFromIso(entry.iso);
      }
    }
    return null;
  }

  static CountryInfo _countryFromIso(String iso) {
    return CountryInfo(
      name: _nameMap[iso] ?? 'India',
      phoneCode: _phoneMap[iso] ?? '+91',
      iso: _phoneMap.containsKey(iso) ? iso : 'IN',
    );
  }

  // ─── Static data ──────────────────────────────────────────────────────────

  static final _nameMap = {
    'US': 'USA',
    'CA': 'Canada',
    'GB': 'England',
    'IN': 'India',
    'AU': 'Australia',
    'DE': 'Germany',
    'FR': 'France',
    'IT': 'Italy',
    'ES': 'Spain',
    'BR': 'Brazil',
    'MX': 'Mexico',
    'AR': 'Argentina',
    'CL': 'Chile',
    'CO': 'Colombia',
    'PE': 'Peru',
    'CN': 'China',
    'JP': 'Japan',
    'KR': 'Korea Republic',
    'SG': 'Singapore',
    'MY': 'Malaysia',
    'TH': 'Thailand',
    'VN': 'Vietnam',
    'PH': 'Philippines',
    'ID': 'Indonesia',
    'PK': 'Pakistan',
    'BD': 'Bangladesh',
    'NG': 'Nigeria',
    'ZA': 'South Africa',
    'EG': 'Egypt',
    'KE': 'Kenya',
    'SA': 'Saudi Arabia',
    'AE': 'United Arab Emirates',
    'TR': 'Türkiye',
    'RU': 'Russia',
    'UA': 'Ukraine',
    'PL': 'Poland',
    'NL': 'Netherlands',
    'BE': 'Belgium',
    'SE': 'Sweden',
    'NO': 'Norway',
    'DK': 'Denmark',
    'FI': 'Finland',
    'PT': 'Portugal',
    'GR': 'Greece',
    'IE': 'Republic of Ireland',
    'NZ': 'New Zealand',
    'CH': 'Switzerland',
    'AT': 'Austria',
    'CZ': 'Czech Republic',
    'HU': 'Hungary',
  };

  static final _phoneMap = {
    'US': '+1',
    'CA': '+1',
    'GB': '+44',
    'IN': '+91',
    'AU': '+61',
    'DE': '+49',
    'FR': '+33',
    'IT': '+39',
    'ES': '+34',
    'BR': '+55',
    'MX': '+52',
    'AR': '+54',
    'CL': '+56',
    'CO': '+57',
    'PE': '+51',
    'CN': '+86',
    'JP': '+81',
    'KR': '+82',
    'SG': '+65',
    'MY': '+60',
    'TH': '+66',
    'VN': '+84',
    'PH': '+63',
    'ID': '+62',
    'PK': '+92',
    'BD': '+880',
    'NG': '+234',
    'ZA': '+27',
    'EG': '+20',
    'KE': '+254',
    'SA': '+966',
    'AE': '+971',
    'TR': '+90',
    'RU': '+7',
    'UA': '+380',
    'PL': '+48',
    'NL': '+31',
    'BE': '+32',
    'SE': '+46',
    'NO': '+47',
    'DK': '+45',
    'FI': '+358',
    'PT': '+351',
    'GR': '+30',
    'IE': '+353',
    'NZ': '+64',
    'CH': '+41',
    'AT': '+43',
    'CZ': '+420',
    'HU': '+36',
  };

  static final _boundingBoxes = [
    _Box('US', 24.4, 49.4, -125.0, -66.9),
    _Box('CA', 41.7, 83.1, -141.0, -52.6),
    _Box('GB', 49.9, 60.9, -8.6, 1.8),
    _Box('IN', 8.0, 37.1, 68.1, 97.4),
    _Box('AU', -43.6, -10.7, 113.3, 153.6),
    _Box('DE', 47.3, 55.1, 5.9, 15.0),
    _Box('FR', 41.3, 51.1, -5.1, 9.6),
    _Box('IT', 36.6, 47.1, 6.6, 18.5),
    _Box('ES', 35.9, 43.8, -9.3, 4.3),
    _Box('BR', -33.7, 5.3, -73.9, -28.8),
    _Box('MX', 14.5, 32.7, -117.1, -86.7),
    _Box('AR', -55.1, -21.8, -73.6, -53.6),
    _Box('CL', -55.9, -17.5, -75.6, -66.4),
    _Box('CO', -4.2, 12.4, -81.8, -66.9),
    _Box('CN', 18.2, 53.6, 73.6, 134.8),
    _Box('JP', 24.0, 45.5, 123.0, 145.8),
    _Box('KR', 33.2, 38.6, 126.0, 129.6),
    _Box('SG', 1.2, 1.5, 103.6, 104.0),
    _Box('MY', 0.8, 7.4, 99.6, 119.3),
    _Box('TH', 5.6, 20.5, 97.3, 105.7),
    _Box('VN', 8.4, 23.4, 102.1, 109.5),
    _Box('PH', 4.6, 21.1, 116.9, 126.6),
    _Box('ID', -11.0, 5.9, 95.0, 141.0),
    _Box('PK', 23.7, 37.1, 60.9, 77.8),
    _Box('BD', 20.7, 26.6, 88.0, 92.7),
    _Box('NG', 4.3, 13.9, 2.7, 14.7),
    _Box('ZA', -34.8, -22.1, 16.5, 32.9),
    _Box('EG', 22.0, 31.7, 24.7, 37.0),
    _Box('KE', -4.7, 5.0, 33.9, 41.9),
    _Box('SA', 16.4, 32.2, 36.5, 55.7),
    _Box('AE', 22.6, 26.1, 51.6, 56.4),
    _Box('TR', 35.8, 42.1, 26.0, 44.8),
    _Box('RU', 41.2, 81.9, 19.6, 180.0),
    _Box('UA', 44.4, 52.4, 22.1, 40.2),
    _Box('PL', 49.0, 54.8, 14.1, 24.2),
    _Box('NL', 50.8, 53.5, 3.3, 7.2),
    _Box('BE', 49.5, 51.5, 2.5, 6.4),
    _Box('SE', 55.3, 69.1, 10.9, 24.2),
    _Box('NO', 57.9, 71.2, 4.5, 31.1),
    _Box('DK', 54.6, 57.8, 8.1, 15.2),
    _Box('FI', 59.8, 70.1, 20.0, 31.6),
    _Box('PT', 37.0, 42.2, -9.5, -6.2),
    _Box('GR', 35.0, 41.7, 19.4, 29.6),
    _Box('IE', 51.4, 55.4, -10.5, -6.0),
    _Box('NZ', -46.6, -34.4, 166.4, 178.6),
    _Box('CH', 45.8, 47.8, 5.9, 10.5),
    _Box('AT', 46.4, 49.0, 9.5, 17.2),
    _Box('CZ', 48.5, 51.1, 12.1, 18.9),
    _Box('HU', 45.7, 48.6, 16.1, 22.9),
  ];
}

class _Box {
  _Box(this.iso, this.minLat, this.maxLat, this.minLng, this.maxLng);
  final String iso;
  final double minLat, maxLat, minLng, maxLng;
}
