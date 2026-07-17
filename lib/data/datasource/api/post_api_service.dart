import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/post_model.dart';

part 'post_api_service.g.dart';

@RestApi()
abstract class PostApiService {
  factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;

  @GET(ApiConstants.posts)
  Future<List<PostModel>> getPosts();

  @GET('${ApiConstants.posts}/{id}')
  Future<PostModel> getPost(@Path('id') int id);

  @POST(ApiConstants.posts)
  Future<PostModel> createPost(@Body() PostModel post);

  @PUT('${ApiConstants.posts}/{id}')
  Future<PostModel> updatePost(@Path('id') int id, @Body() PostModel post);

  @PATCH('${ApiConstants.posts}/{id}')
  Future<PostModel> patchPost(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('${ApiConstants.posts}/{id}')
  Future<void> deletePost(@Path('id') int id);
}
