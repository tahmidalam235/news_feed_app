import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/post_model.dart';
import '../providers/usecase_provider.dart';

final postsControllerProvider =
AsyncNotifierProvider<PostsController, List<PostModel>>(
  PostsController.new,
);

class PostsController extends AsyncNotifier<List<PostModel>> {
  @override
  Future<List<PostModel>> build() async {
    return ref.read(getPostsUseCaseProvider).call();
  }

  Future<void> createPost({
    required String title,
    required String body,
  }) async {
    final post = await ref.read(createPostUseCaseProvider).call(
      PostModel(
        userId: 1,
        title: title,
        body: body,
      ),
    );

    final current = state.value ?? [];

    state = AsyncData([
      post,
      ...current,
    ]);
  }

  Future<void> updatePost(
      int id,
      String title,
      String body,
      ) async {
    final updated = await ref.read(updatePostUseCaseProvider).call(
      id,
      PostModel(
        id: id,
        userId: 1,
        title: title,
        body: body,
      ),
    );

    final posts = state.value ?? [];

    state = AsyncData(
      posts.map((e) => e.id == id ? updated : e).toList(),
    );
  }

  Future<void> patchPost(
      int id,
      String title,
      ) async {
    final updated = await ref.read(patchPostUseCaseProvider).call(
      id,
      {
        "title": title,
      },
    );

    final posts = state.value ?? [];

    state = AsyncData(
      posts.map((e) => e.id == id ? updated : e).toList(),
    );
  }

  Future<void> deletePost(int id) async {
    await ref.read(deletePostUseCaseProvider).call(id);

    final posts = state.value ?? [];

    state = AsyncData(
      posts.where((e) => e.id != id).toList(),
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(getPostsUseCaseProvider).call();
    });
  }
}