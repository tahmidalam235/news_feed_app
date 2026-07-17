import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/post_details_controller.dart';

@RoutePage()
class PostDetailsPage extends ConsumerWidget {
  final int postId;

  const PostDetailsPage({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postDetailsProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: post.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Text(e.toString()),
        ),
        data: (post) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  "Post ID : ${post.id}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),

                Text(
                  "User ID : ${post.userId}",
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Title",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  post.title,
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Body",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  post.body,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            )
          );
        },
      ),
    );
  }
}