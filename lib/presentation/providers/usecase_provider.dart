import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/delete_post_usecase.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/patch_post_usecase.dart';
import '../../domain/usecases/update_post_usecase.dart';
import 'repository_provider.dart';

final getPostsUseCaseProvider = Provider((ref) {
  return GetPostsUseCase(ref.read(postRepositoryProvider));
});

final getPostUseCaseProvider = Provider((ref) {
  return GetPostUseCase(ref.read(postRepositoryProvider));
});

final createPostUseCaseProvider = Provider((ref) {
  return CreatePostUseCase(ref.read(postRepositoryProvider));
});

final updatePostUseCaseProvider = Provider((ref) {
  return UpdatePostUseCase(ref.read(postRepositoryProvider));
});

final patchPostUseCaseProvider = Provider((ref) {
  return PatchPostUseCase(ref.read(postRepositoryProvider));
});

final deletePostUseCaseProvider = Provider((ref) {
  return DeletePostUseCase(ref.read(postRepositoryProvider));
});
