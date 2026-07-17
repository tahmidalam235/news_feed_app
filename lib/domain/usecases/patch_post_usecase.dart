import '../../data/models/post_model.dart';
import '../repository/post_repository.dart';

class PatchPostUseCase {
  final PostRepository repository;

  PatchPostUseCase(this.repository);

  Future<PostModel> call(int id, Map<String, dynamic> body) {
    return repository.patchPost(id, body);
  }
}
