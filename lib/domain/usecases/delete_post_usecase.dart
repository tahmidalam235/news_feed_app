import '../repository/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deletePost(id);
  }
}
