import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../data/models/club_bio_model.dart';
import '../data/repositories/club_repository.dart';

/// Provider for single club bio/details.
/// Returns (ClubBioModel?, npsSurvey) — the npsSurvey bool mirrors the
/// server-driven flag that triggers the NPS rating dialog (same as Android).
final clubBioProvider =
    FutureProvider.family<(ClubBioModel?, bool), String>((ref, clubId) async {
  final userId = StorageService.userId ?? '';
  return ref.read(clubRepositoryProvider).getClubBio(
        clubId: clubId,
        userId: userId,
      );
});

/// Provider for follow club action.
/// Returns the server-side isFollow flag (nullable — null means error).
final followClubProvider =
    FutureProvider.family<bool?, String>((ref, clubId) async {
  final userId = StorageService.userId ?? '';
  final isFollow = await ref.read(clubRepositoryProvider).followClub(
        clubId: clubId,
        userId: userId,
      );

  // Invalidate club bio to refresh follow status
  if (isFollow != null) {
    ref.invalidate(clubBioProvider(clubId));
  }

  return isFollow;
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

/// Provider for submitting the NPS 5-question survey.
/// Returns true if the server acknowledged (status field present in response).
final saveNpsProvider = FutureProvider.family<
    bool,
    ({
      int q1,
      int q2,
      int q3,
      int q4,
      int q5,
      String comment,
    })>((ref, params) async {
  return ref.read(clubRepositoryProvider).saveNps(
        q1: params.q1,
        q2: params.q2,
        q3: params.q3,
        q4: params.q4,
        q5: params.q5,
        comment: params.comment.isEmpty ? null : params.comment,
      );
});
