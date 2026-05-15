import 'dart:developer';

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
  const ClubBioAdminScreen({super.key});

  @override
  ConsumerState<ClubBioAdminScreen> createState() => _ClubBioAdminScreenState();
}

class _ClubBioAdminScreenState extends ConsumerState<ClubBioAdminScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final name = StorageService.clubUser?['clubName'] as String? ?? 'Club';
      ref.read(clubAppBarTitleProvider.notifier).state = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(_clubBioAdminProvider);

    return async.when(
      loading: () => const AppLoader(),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (bio) {
        if (bio == null) {
          return const Center(child: Text('Could not load club data. '));
        }
        return _BioBody(
            bio: bio, onRefresh: () => ref.invalidate(_clubBioAdminProvider));
      },
    );
  }
}

class _BioBody extends ConsumerWidget {
  const _BioBody({required this.bio, required this.onRefresh});
  final ClubBioModel bio;
  final VoidCallback onRefresh;

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text('$label:',
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w700),
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
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    club.clubName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(width: 1.5, height: 24, color: AppColors.socaBlack),
                  const SizedBox(width: 12),
                  const Icon(Icons.workspace_premium_outlined,
                      color: AppColors.socaBlack),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.photo_library_outlined,
                        color: AppColors.socaBlack),
                    onPressed: () => context.push(AppRoutes.clubGallery),
                  ),
                  if (club.website != null && club.website!.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.language,
                          color: AppColors.socaBlack),
                      onPressed: () => launchUrl(Uri.parse(club.website!)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Club info ─────────────────────────────────────────────────
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    club.clubName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                            padding: const EdgeInsets.all(4),
                            child: logoUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: logoUrl, fit: BoxFit.contain)
                                : const Icon(Icons.shield,
                                    color: AppColors.socaYellow, size: 48),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${club.followCount} Follower${club.followCount != 1 ? 's' : ''}',
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Info Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Nickname', club.nickName ?? ''),
                            _buildInfoRow('Formed In', club.formedYear ?? ''),
                            _buildInfoRow('Country', club.country ?? ''),
                            _buildInfoRow('City', club.city ?? ''),
                            _buildInfoRow('Stadium', club.stadiumsAsStr),
                            _buildInfoRow('Manager', club.manager ?? ''),
                            const SizedBox(height: 4),
                            const Text('League',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13)),
                            if (club.league != null && club.league!.isNotEmpty)
                              Text(club.league!,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            const Text('Other Competitions',
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13)),
                            if (club.confed != null && club.confed!.isNotEmpty)
                              Text(club.confed!,
                                  style: const TextStyle(
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
            const SizedBox(height: 12),

            Container(
                color: AppColors.socaGrey,
                child: Column(children: [
                  // ── Club Teams ────────────────────────────────────────────────
                  const _SectionHeader(title: 'Club Teams'),
                  if (bio.teamList.isNotEmpty)
                    Container(
                      // color: Colors.grey.shade100,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 12,
                        children: bio.teamList.map((t) {
                          if (t.ageGroup != null && t.ageGroup!.isNotEmpty) {
                            return RichText(
                              text: TextSpan(
                                text: '${t.ageGroup ?? ''} ',
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          t.gender == 'male' ? 'Men' : 'Women',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            );
                          }
                          return Text(t.teamName ?? '',
                              style: const TextStyle(
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
                  const _SectionHeader(
                      title: 'Home Kit | Away Kit | Third Kit'),
                  Container(
                    color: Colors.grey.shade200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
                  const _SectionHeader(title: 'Club Sponsors'),
                  if (bio.sponsorList.isNotEmpty)
                    Container(
                      // color: Colors.grey.shade100,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
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
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600))),
                          );
                        }).toList(),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: const Text('Kit',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── Small helper widgets ──────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
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
  const _KitCard({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    final fullUrl = ApiConstants.getImageUrl(url);
    return Expanded(
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: fullUrl.isNotEmpty
            ? CachedNetworkImage(imageUrl: fullUrl, fit: BoxFit.contain)
            : Image.asset("assets/images/kit.png"),
      ),
    );
  }
}
