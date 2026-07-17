import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_router.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../widgets/empty_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_card.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News Feed",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(
            const CreatePostRoute(),
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const LoadingWidget();
          }

          if (state is PostError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<PostBloc>().add(
                  const RefreshPostsEvent(),
                );
              },
            );
          }

          if (state is PostLoaded) {
            final data = state.posts;

            if (data.isEmpty) {
              return const EmptyWidget(
                message: "No Posts Found",
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostBloc>().add(
                  const RefreshPostsEvent(),
                );
              },
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  return PostCard(
                    post: data[index],

                    onView: () {
                      context.router.push(
                        PostDetailsRoute(
                          post: data[index],
                        ),
                      );
                    },

                    onEdit: () {
                      context.router.push(
                        EditPostRoute(
                          post: data[index],
                        ),
                      );
                    },

                    onDelete: () async {
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Delete Post"),
                            content: const Text(
                              "Are you sure you want to delete this post?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldDelete != true) return;

                      context.read<PostBloc>().add(
                        DeletePostEvent(
                          id: data[index].id!,
                        ),
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Post Deleted"),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}