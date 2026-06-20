import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/sponsor_charity_bio_models.dart';
import '../data/repositories/partners_repository.dart';

final charityBioProvider =
    FutureProvider.family<CharityBioModel?, String>((ref, charityId) async {
  return ref
      .read(partnersRepositoryProvider)
      .getCharityBio(charityId: charityId);
});
