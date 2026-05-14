import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../data/models/academy_bio_models.dart';
import 'academies_provider.dart';

final academyBioProvider =
    FutureProvider.family<AcademyBioData?, String>((ref, academyId) async {
  final userId = StorageService.userId ?? '';
  return ref.read(academiesRepositoryProvider).getAcademyBio(
        userId: userId,
        academyId: academyId,
      );
});
