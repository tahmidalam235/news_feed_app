import '../../data/models/post_model.dart';
import '../repository/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<PostModel> call(int id, PostModel post) {
    return repository.updatePost(id, post);
  }
}
