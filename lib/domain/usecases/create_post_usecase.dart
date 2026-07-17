import '../../data/models/post_model.dart';
import '../repository/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Future<PostModel> call(PostModel post) {
    return repository.createPost(post);
  }
}
