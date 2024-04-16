import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innotest/src/routing/app_router.dart';

import 'logic/repo/app_repository.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(appRepositoryProvider.notifier).checkLoggedInUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appRepositoryProvider.select((value) => value.appStatus),
        (previous, next) {
      if (next != previous) {
        if (next == AppState.authenticated) {
          _appRouter.pushAndPopUntil(
            const HomeRoute(),
            predicate: (Route<dynamic> route) => false,
          );
        } else if (next == AppState.unauthenticated) {
          _appRouter.pushAndPopUntil(
            const LoginRoute(),
            predicate: (Route<dynamic> route) => false,
          );
        }
      }
    });
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
