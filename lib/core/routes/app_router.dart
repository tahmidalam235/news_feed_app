import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../data/models/post_model.dart';
import '../../presentation/pages/create_post_page.dart';
import '../../presentation/pages/edit_post_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/post_details_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: PostDetailsRoute.page),
    AutoRoute(page: CreatePostRoute.page),
    AutoRoute(page: EditPostRoute.page),
  ];
}
