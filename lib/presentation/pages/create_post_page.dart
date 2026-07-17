import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

@RoutePage()
class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  bool loading = false;

  Future<void> create() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    context.read<PostBloc>().add(
      CreatePostEvent(
        title: titleController.text,
        body: bodyController.text,
      ),
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Post Created"),
      ),
    );

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
        title: const Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Create New Post",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
                text: "Create",
                loading: loading,
                onPressed: create,
              ),
            ],
          ),
        ),
      ),
    );
  }
}