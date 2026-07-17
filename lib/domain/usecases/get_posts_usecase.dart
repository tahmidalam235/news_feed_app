import '../../data/models/post_model.dart';
import '../repository/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostModel>> call() {
    return repository.getPosts();
  }
}
