import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/fa_bio_model.dart';
import '../data/repositories/partners_repository.dart';

final faBioProvider =
    FutureProvider.family<FaBioModel?, String>((ref, faId) async {
  return ref.read(partnersRepositoryProvider).getFaBio(faId: faId);
});
