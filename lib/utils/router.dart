import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/screens/homeScreen.dart';
import 'package:movie_db/screens/movieScreen.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/movie',
      builder: (BuildContext context, GoRouterState state) {
        return const MovieScreen();
      },
    ),
  ],
);
