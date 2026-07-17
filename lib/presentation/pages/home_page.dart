import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/posts_controller.dart';
import '../widgets/post_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/error_widget.dart';
import '../../core/routes/app_router.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsControllerProvider);

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
      body: posts.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => AppErrorWidget(
          message: e.toString(),
          onRetry: () {
            ref.read(postsControllerProvider.notifier).refresh();
          },
        ),
        data: (data) {
          if (data.isEmpty) {
            return const EmptyWidget(
              message: "No Posts Found",
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(postsControllerProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                return PostCard(
                  post: data[index],

                  onView: () {
                    context.router.push(
                      PostDetailsRoute(
                        postId: data[index].id!,
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
                            )
                          ],
                        );
                      },
                    );

                    if (shouldDelete != true) return;

                    await ref
                        .read(postsControllerProvider.notifier)
                        .deletePost(data[index].id!);

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
        },
      ),
    );
  }
}