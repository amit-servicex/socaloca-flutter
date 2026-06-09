import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/club/data/models/club_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_bio_model.dart';
import '../data/repositories/club_repository.dart';
import 'club_home_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

// ── Provider ──────────────────────────────────────────────────────────────────
final _clubBioAdminProvider =
    FutureProvider.autoDispose<ClubBioModel?>((ref) async {
  final clubId = StorageService.clubId ?? '';
  log("this is the club id from storage $clubId");
  if (clubId.isEmpty) {
    throw Exception(
      'Club ID not found in storage. '
      'Club user data: ${StorageService.clubUser}',
    );
  }
  return ref.read(clubRepositoryProvider).getClubBioAdmin(clubId: clubId);
});

/// Club Bio Admin Dashboard — Screen 1 of the Club shell.
class ClubBioAdminScreen extends ConsumerStatefulWidget {
  ClubBioAdminScreen({super.key});

  @override
  ConsumerState<ClubBioAdminScreen> createState() => _ClubBioAdminScreenState();
}

class _ClubBioAdminScreenState extends ConsumerState<ClubBioAdminScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final name =
          StorageService.clubUser?['clubName'] as String? ?? AppStrings.club;
      ref.read(clubAppBarTitleProvider.notifier).state = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(_clubBioAdminProvider);

    return async.when(
      loading: () => AppLoader(),
      error: (e, _) => Center(child: Text(AppStrings.errorMessage(e))),
      data: (bio) {
        if (bio == null) {
          return Center(child: Text(AppStrings.couldNotLoadClubData));
        }
        return _BioBody(
            bio: bio, onRefresh: () => ref.invalidate(_clubBioAdminProvider));
      },
    );
  }
}

class _BioBody extends ConsumerWidget {
  _BioBody({required this.bio, required this.onRefresh});
  final ClubBioModel bio;
  final VoidCallback onRefresh;

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text('$label:',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final club = bio.clubDetails;
    final isPartner = club.isPartner;
    final logoUrl = ApiConstants.getImageUrl(club.imageUrl);

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Bar ──────────────────────────────────────────────
            Container(
              // color: AppColors.socaGrey,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    club.clubName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(width: 1.5, height: 24, color: AppColors.socaBlack),
                  SizedBox(width: 12),
                  Image.asset("assets/icons/ic_platinum_badge.png",
                      width: 28, height: 28),
                  Spacer(),
                  IconButton(
                    icon: Image.asset("assets/icons/ic_gallery_new.png",
                        width: 28, height: 28),
                    onPressed: () => context.push(AppRoutes.clubGallery),
                  ),
                  if (club.website != null && club.website!.isNotEmpty)
                    IconButton(
                      icon: Image.asset("assets/icons/ic_website.png",
                          width: 28, height: 28),
                      onPressed: () => launchUrl(Uri.parse(club.website!)),
                    ),
                ],
              ),
            ),
            SizedBox(height: 12),

            // ── Club info ─────────────────────────────────────────────────
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    club.clubName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo Column
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.black,
                            padding: EdgeInsets.all(4),
                            child: logoUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: logoUrl, fit: BoxFit.contain)
                                : Icon(Icons.shield,
                                    color: AppColors.socaYellow, size: 48),
                          ),
                          SizedBox(height: 8),
                          Text(
                            AppStrings.followersCount(club.followCount),
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      // Info Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                AppStrings.nickname, club.nickName ?? ''),
                            _buildInfoRow(
                                AppStrings.formedIn, club.formedYear ?? ''),
                            _buildInfoRow(
                                AppStrings.country, club.country ?? ''),
                            _buildInfoRow(AppStrings.city, club.city ?? ''),
                            _buildInfoRow(
                                AppStrings.stadium, club.stadiumsAsStr),
                            _buildInfoRow(
                                AppStrings.manager, club.manager ?? ''),
                            SizedBox(height: 4),
                            Text(AppStrings.league,
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13)),
                            if (club.league != null && club.league!.isNotEmpty)
                              Text(club.league!,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            SizedBox(height: 4),
                            Text(AppStrings.otherCompetitions,
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13)),
                            if (club.confed != null && club.confed!.isNotEmpty)
                              Text(club.confed!,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),

            Container(
                color: AppColors.socaGrey,
                child: Column(children: [
                  // ── Club Teams ────────────────────────────────────────────────
                  _SectionHeader(title: AppStrings.clubTeams),
                  if (bio.teamList.isNotEmpty)
                    Container(
                      // color: Colors.grey.shade100,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 12,
                        children: bio.teamList.map((t) {
                          if (t.ageGroup != null && t.ageGroup!.isNotEmpty) {
                            return RichText(
                              text: TextSpan(
                                text: '${t.ageGroup ?? ''} ',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: t.gender == 'male'
                                          ? AppStrings.men
                                          : AppStrings.women,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            );
                          }
                          return Text(t.teamName ?? '',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600));
                        }).toList(),
                      ),
                    ),
                ])),

            SizedBox(height: 12),
            Container(
              color: AppColors.socaGrey,
              child: Column(
                children: [
                  // ── Kits ───────────────────────────────────────────────────
                  _SectionHeader(title: AppStrings.homeAwayThirdKit),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          _KitCard(url: club.homeKit),
                          VerticalDivider(
                              width: 0,
                              thickness: 1,
                              color: AppColors.socaBlack),
                          _KitCard(url: club.awayKit),
                          VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: AppColors.socaBlack),
                          _KitCard(url: club.thirdKit),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),

            Container(
              color: AppColors.socaGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ── Club Sponsors ──────────────────────────────────────────────────
                  _SectionHeader(title: AppStrings.clubSponsors),
                  if (bio.sponsorList.isNotEmpty)
                    Container(
                      // color: Colors.grey.shade100,
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: bio.sponsorList.map((s) {
                          final url = ApiConstants.getImageUrl(s.logo);
                          return Container(
                            width: 70,
                            height: 37,
                            color: Colors.transparent,
                            child: url.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: url, fit: BoxFit.contain)
                                : Center(
                                    child: Text(s.name ?? '',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600))),
                          );
                        }).toList(),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(AppStrings.kit,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── Small helper widgets ──────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.socaBlack,
            ),
          ),
        ),
        Divider(
          thickness: .8,
          color: AppColors.socaBlack,
          height: 0,
        )
      ],
    );
  }
}

class _KitCard extends StatelessWidget {
  _KitCard({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    final fullUrl = ApiConstants.getImageUrl(url);
    return Expanded(
      child: Container(
        height: 140,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: fullUrl.isNotEmpty
            ? CachedNetworkImage(imageUrl: fullUrl, fit: BoxFit.contain)
            : Image.asset("assets/images/kit.png"),
      ),
    );
  }
}
