import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post_model.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

@RoutePage()
class EditPostPage extends StatefulWidget {
  final PostModel post;

  const EditPostPage({
    super.key,
    required this.post,
  });

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
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

    context.read<PostBloc>().add(
      UpdatePostEvent(
        id: widget.post.id!,
        title: titleController.text,
        body: bodyController.text,
      ),
    );

    setState(() => loading = false);

    if (!mounted) return;

    context.router.pop();
  }

  Future<void> patchUpdate() async {
    setState(() => loading = true);

    context.read<PostBloc>().add(
      PatchPostEvent(
        id: widget.post.id!,
        title: titleController.text,
      ),
    );

    setState(() => loading = false);

    if (!mounted) return;

    context.router.pop();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Update Post",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 25),
              AppTextField(
                controller: titleController,
                hint: "Title",
              ),
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
                loading: loading,
                onPressed: patchUpdate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}