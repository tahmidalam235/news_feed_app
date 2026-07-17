import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LoadPostsEvent extends PostEvent {
  const LoadPostsEvent();
}

class RefreshPostsEvent extends PostEvent {
  const RefreshPostsEvent();
}

class CreatePostEvent extends PostEvent {
  final String title;
  final String body;

  const CreatePostEvent({
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [title, body];
}

class UpdatePostEvent extends PostEvent {
  final int id;
  final String title;
  final String body;

  const UpdatePostEvent({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];
}

class PatchPostEvent extends PostEvent {
  final int id;
  final String title;

  const PatchPostEvent({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}

class DeletePostEvent extends PostEvent {
  final int id;

  const DeletePostEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}