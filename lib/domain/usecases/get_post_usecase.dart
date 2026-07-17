import '../../data/models/post_model.dart';
import '../repository/post_repository.dart';

class GetPostUseCase {
  final PostRepository repository;

  GetPostUseCase(this.repository);

  Future<PostModel> call(int id) {
    return repository.getPost(id);
  }
}
