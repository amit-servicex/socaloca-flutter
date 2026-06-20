import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/sponsor_charity_bio_models.dart';
import '../data/repositories/partners_repository.dart';

final sponsorBioProvider =
    FutureProvider.family<SponsorBioModel?, String>((ref, sponsorId) async {
  return ref
      .read(partnersRepositoryProvider)
      .getSponsorBio(sponsorId: sponsorId);
});
