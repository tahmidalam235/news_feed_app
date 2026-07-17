import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_router.dart';
import 'data/repository/post_repository_impl.dart';
import 'domain/usecases/create_post_usecase.dart';
import 'domain/usecases/delete_post_usecase.dart';
import 'domain/usecases/get_posts_usecase.dart';
import 'domain/usecases/patch_post_usecase.dart';
import 'domain/usecases/update_post_usecase.dart';
import 'presentation/bloc/post_bloc.dart';
import 'presentation/bloc/post_event.dart';

void main() {
  final repository = PostRepositoryImpl();

  runApp(
    BlocProvider(
      create: (_) => PostBloc(
        getPostsUseCase: GetPostsUseCase(repository),
        createPostUseCase: CreatePostUseCase(repository),
        updatePostUseCase: UpdatePostUseCase(repository),
        patchPostUseCase: PatchPostUseCase(repository),
        deletePostUseCase: DeletePostUseCase(repository),
      )..add(const LoadPostsEvent()),
      child: const NewsFeedApp(),
    ),
  );
}

class NewsFeedApp extends StatelessWidget {
  const NewsFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'News Feed App',
      routerConfig: appRouter.config(),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xffF5F7FA),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}