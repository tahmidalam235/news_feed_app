import '../../data/models/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();

  Future<PostModel> getPost(int id);

  Future<PostModel> createPost(PostModel post);

  Future<PostModel> updatePost(int id, PostModel post);

  Future<PostModel> patchPost(int id, Map<String, dynamic> body);

  Future<void> deletePost(int id);
}
