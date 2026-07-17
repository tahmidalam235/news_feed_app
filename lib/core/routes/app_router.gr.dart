// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CreatePostPage]
class CreatePostRoute extends PageRouteInfo<void> {
  const CreatePostRoute({List<PageRouteInfo>? children})
    : super(CreatePostRoute.name, initialChildren: children);

  static const String name = 'CreatePostRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreatePostPage();
    },
  );
}

/// generated route for
/// [EditPostPage]
class EditPostRoute extends PageRouteInfo<EditPostRouteArgs> {
  EditPostRoute({
    Key? key,
    required PostModel post,
    List<PageRouteInfo>? children,
  }) : super(
         EditPostRoute.name,
         args: EditPostRouteArgs(key: key, post: post),
         initialChildren: children,
       );

  static const String name = 'EditPostRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditPostRouteArgs>();
      return EditPostPage(key: args.key, post: args.post);
    },
  );
}

class EditPostRouteArgs {
  const EditPostRouteArgs({this.key, required this.post});

  final Key? key;

  final PostModel post;

  @override
  String toString() {
    return 'EditPostRouteArgs{key: $key, post: $post}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditPostRouteArgs) return false;
    return key == other.key && post == other.post;
  }

  @override
  int get hashCode => key.hashCode ^ post.hashCode;
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [PostDetailsPage]
class PostDetailsRoute extends PageRouteInfo<PostDetailsRouteArgs> {
  PostDetailsRoute({
    Key? key,
    required PostModel post,
    List<PageRouteInfo>? children,
  }) : super(
         PostDetailsRoute.name,
         args: PostDetailsRouteArgs(key: key, post: post),
         initialChildren: children,
       );

  static const String name = 'PostDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostDetailsRouteArgs>();
      return PostDetailsPage(key: args.key, post: args.post);
    },
  );
}

class PostDetailsRouteArgs {
  const PostDetailsRouteArgs({this.key, required this.post});

  final Key? key;

  final PostModel post;

  @override
  String toString() {
    return 'PostDetailsRouteArgs{key: $key, post: $post}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostDetailsRouteArgs) return false;
    return key == other.key && post == other.post;
  }

  @override
  int get hashCode => key.hashCode ^ post.hashCode;
}
