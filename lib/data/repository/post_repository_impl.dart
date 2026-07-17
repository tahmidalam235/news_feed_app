import 'package:dio/dio.dart';

import '../../core/error/app_exception.dart';
import '../../core/network/dio_client.dart';
import '../../domain/repository/post_repository.dart';
import '../datasource/api/post_api_service.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl() : _api = PostApiService(DioClient.instance);

  final PostApiService _api;

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw TimeoutException();

        case DioExceptionType.connectionError:
          throw NetworkException();

        case DioExceptionType.badResponse:
          throw ServerException();

        default:
          throw UnknownException();
      }
    } catch (_) {
      throw UnknownException();
    }
  }

  @override
  Future<List<PostModel>> getPosts() => _handleRequest(() => _api.getPosts());

  @override
  Future<PostModel> getPost(int id) => _handleRequest(() => _api.getPost(id));

  @override
  Future<PostModel> createPost(PostModel post) =>
      _handleRequest(() => _api.createPost(post));

  @override
  Future<PostModel> updatePost(int id, PostModel post) =>
      _handleRequest(() => _api.updatePost(id, post));

  @override
  Future<PostModel> patchPost(int id, Map<String, dynamic> body) =>
      _handleRequest(() => _api.patchPost(id, body));

  @override
  Future<void> deletePost(int id) => _handleRequest(() => _api.deletePost(id));
}
