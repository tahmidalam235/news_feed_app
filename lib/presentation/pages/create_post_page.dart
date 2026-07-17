import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/posts_controller.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

@RoutePage()
class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final bodyController = TextEditingController();

  bool loading = false;

  Future<void> create() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    await ref
        .read(postsControllerProvider.notifier)
        .createPost(title: titleController.text, body: bodyController.text);

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Post Created")));

    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),

              const Text(
                "Create New Post",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),
              AppTextField(controller: titleController, hint: "Title"),
              const SizedBox(height: 20),
              AppTextField(
                controller: bodyController,
                hint: "Body",
                maxLines: 5,
              ),
              const SizedBox(height: 30),
              AppButton(text: "Create", loading: loading, onPressed: create),
            ],
          ),
        ),
      ),
    );
  }
}
