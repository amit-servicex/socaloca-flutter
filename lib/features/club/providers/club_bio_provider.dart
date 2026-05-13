import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../data/models/club_bio_model.dart';
import '../data/repositories/club_repository.dart';

/// Provider for single club bio/details
final clubBioProvider =
    FutureProvider.family<ClubBioModel?, String>((ref, clubId) async {
  final userId = StorageService.userId ?? '';
  return ref.read(clubRepositoryProvider).getClubBio(
        clubId: clubId,
        userId: userId,
      );
});

/// Provider for follow club action
final followClubProvider =
    FutureProvider.family<bool, String>((ref, clubId) async {
  final userId = StorageService.userId ?? '';
  final success = await ref.read(clubRepositoryProvider).followClub(
        clubId: clubId,
        userId: userId,
      );

  // Invalidate club bio to refresh follow status
  if (success) {
    ref.invalidate(clubBioProvider(clubId));
  }

  return success;
});

/// Provider for trial registration action
final trialRegisterProvider = FutureProvider.family<
    bool,
    ({
      String clubId,
      String trialId,
      String email,
    })>((ref, params) async {
  final success = await ref.read(clubRepositoryProvider).trialRegisterByTrialId(
        trialId: params.trialId,
        email: params.email,
      );

  // Invalidate club bio to refresh trial status
  if (success) {
    ref.invalidate(clubBioProvider(params.clubId));
  }

  return success;
});
