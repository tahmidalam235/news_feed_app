import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../data/models/post_model.dart';

@RoutePage()
class PostDetailsPage extends StatelessWidget {
  final PostModel post;

  const PostDetailsPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Post ID : ${post.id}"),
              const SizedBox(height: 12),

              Text("User ID : ${post.userId}"),
              const SizedBox(height: 30),

              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(post.title),

              const SizedBox(height: 24),

              const Text(
                "Body",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(post.body),
            ],
          ),
        ),
      ),
    );
  }
}