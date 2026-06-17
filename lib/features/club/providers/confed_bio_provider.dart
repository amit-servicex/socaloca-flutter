import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/confed_bio_model.dart';
import '../data/repositories/partners_repository.dart';

final confedBioProvider =
    FutureProvider.family<ConfedBioModel?, String>((ref, confedId) async {
  return ref.read(partnersRepositoryProvider).getConfedBio(confedId: confedId);
});
