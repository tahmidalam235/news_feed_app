import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post_model.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/delete_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/patch_post_usecase.dart';
import '../../domain/usecases/update_post_usecase.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final PatchPostUseCase patchPostUseCase;
  final DeletePostUseCase deletePostUseCase;

  List<PostModel> _posts = [];

  PostBloc({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.patchPostUseCase,
    required this.deletePostUseCase,
  }) : super(const PostInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<RefreshPostsEvent>(_onRefreshPosts);
    on<CreatePostEvent>(_onCreatePost);
    on<UpdatePostEvent>(_onUpdatePost);
    on<PatchPostEvent>(_onPatchPost);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _onLoadPosts(
      LoadPostsEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(const PostLoading());

    try {
      _posts = await getPostsUseCase();

      emit(PostLoaded(List.from(_posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onRefreshPosts(
      RefreshPostsEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(const PostLoading());

    try {
      _posts = await getPostsUseCase();

      emit(PostLoaded(List.from(_posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onCreatePost(
      CreatePostEvent event,
      Emitter<PostState> emit,
      ) async {
    try {
      final post = await createPostUseCase(
        PostModel(
          userId: 1,
          title: event.title,
          body: event.body,
        ),
      );

      _posts = [post, ..._posts];

      emit(PostLoaded(List.from(_posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUpdatePost(
      UpdatePostEvent event,
      Emitter<PostState> emit,
      ) async {
    try {
      final updated = await updatePostUseCase(
        event.id,
        PostModel(
          id: event.id,
          userId: 1,
          title: event.title,
          body: event.body,
        ),
      );

      _posts = _posts
          .map((e) => e.id == event.id ? updated : e)
          .toList();

      emit(PostLoaded(List.from(_posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onPatchPost(
      PatchPostEvent event,
      Emitter<PostState> emit,
      ) async {
    try {
      final updated = await patchPostUseCase(
        event.id,
        {
          "title": event.title,
        },
      );

      _posts = _posts
          .map((e) => e.id == event.id ? updated : e)
          .toList();

      emit(PostLoaded(List.from(_posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onDeletePost(
      DeletePostEvent event,
      Emitter<PostState> emit,
      ) async {
    try {
      await deletePostUseCase(event.id);

      _posts = _posts
          .where((e) => e.id != event.id)
          .toList();

      emit(PostLoaded(List.from(_posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}