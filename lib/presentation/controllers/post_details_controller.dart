import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/post_model.dart';
import '../providers/usecase_provider.dart';

final postDetailsProvider = FutureProvider.family<PostModel, int>((
  ref,
  id,
) async {
  return ref.read(getPostUseCaseProvider).call(id);
});
