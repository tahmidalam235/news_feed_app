import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/post_model.dart';
import '../controllers/posts_controller.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

@RoutePage()
class EditPostPage extends ConsumerStatefulWidget {
  final PostModel post;

  const EditPostPage({super.key, required this.post});

  @override
  ConsumerState<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends ConsumerState<EditPostPage> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController bodyController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.post.title);
    bodyController = TextEditingController(text: widget.post.body);
  }

  Future<void> putUpdate() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    await ref
        .read(postsControllerProvider.notifier)
        .updatePost(widget.post.id!, titleController.text, bodyController.text);

    if (!mounted) return;

    setState(() => loading = false);

    context.router.pop();
  }

  Future<void> patchUpdate() async {
    setState(() => loading = true);

    await ref
        .read(postsControllerProvider.notifier)
        .patchPost(widget.post.id!, titleController.text);

    if (!mounted) return;

    setState(() => loading = false);

    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Post")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),

              const Text(
                "Update Post",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
              AppButton(
                text: "PUT Update",
                loading: loading,
                onPressed: putUpdate,
              ),
              const SizedBox(height: 15),
              AppButton(
                text: "PATCH Update",
                loading: false,
                onPressed: patchUpdate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
