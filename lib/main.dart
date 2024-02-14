import 'package:flutter/material.dart';
import 'package:movie_db/utils/router.dart' as imported_router;

void main() => runApp(const MyApp());

var appRouter = imported_router.router;

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
