/// A complete usage example for the `rooute` package.
///
/// Demonstrates:
/// - Initializing a Flutter app using [RoutableApp]
/// - Defining strongly-typed enum routes via [Rooute]
/// - Navigating using enum methods
/// - Configuring Material, Cupertino, Adaptive, and Custom transitions
///
/// **Navigation Flow:**
/// 1. App launches → initial route = `MyRoutes.launcher`
/// 2. `LauncherScreen` waits 1 second
/// 3. Redirects to `MyRoutes.home`
/// 4. Routes are resolved using the enum-based registry
//
// ignore_for_file: avoid_print

library;

import 'package:flutter/material.dart';
import 'package:rooute/rooute.dart';

void main() {
  runApp(const App());
}

/// Root widget for the example application.
///
/// Uses [RoutableApp] to automatically wire `onGenerateRoute` using
/// enum-based routes, avoiding manual switch-case routing.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => RoutableApp(
    launcher: MyRoutes.launcher,
    builder: (initialRoute, onGenerateRoute) => MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
    ),
  );
}

/// The first screen displayed when the application starts.
///
/// Demonstrates enum-based routing from lifecycle events.
/// Automatically transitions to [Home] after 1 second.
class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    _moveToHome(context);
  }

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Placeholder(color: Colors.red));

  /// Delays briefly and then pushes the home route.
  ///
  /// Example usage:
  /// ```dart
  /// MyRoutes.home.push(context, arguments: 'Hello Home');
  /// ```
  Future<void> _moveToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      await MyRoutes.home.push(
        context,
        arguments: 'String argument sent from Launcher',
      );
    }
  }
}

/// The main home screen.
///
/// Demonstrates retrieving route arguments using
/// [RoutableApp.arguments].
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _printArgs();
  }

  void _printArgs() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      print(RoutableApp.arguments<String>(context) ?? 'No args received');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Text(RoutableApp.arguments<String>(context) ?? 'No args received'),
    ),
  );
}

/// Enum defining all routes in the application.
///
/// Each enum value maps to a [RoouteBuilder], which defines **how**
/// the page transition should be built (Material, Cupertino, Adaptive, or Custom).
///
/// Demonstrates:
/// - Material transition for `launcher`
/// - Cupertino transition for `home`
/// - Custom PageRouteBuilder transition for `customPage`
enum MyRoutes with Rooute<MyRoutes> {
  /// First screen shown at app launch.
  launcher,

  /// Main home screen.
  home,

  /// A route with fully custom transition animation.
  ///
  /// Use this for slides, fades, or complex animations.
  customPage;

  /// Maps enum values to their respective [RoouteBuilder].
  @override
  Map<MyRoutes, RoouteBuilder> get routes => {
    launcher: RoouteBuilder.material(() => const LauncherScreen()),

    home: RoouteBuilder.cupertino(() => const Home()),

    customPage: RoouteBuilder.custom(
      (settings) => PageRouteBuilder(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Scaffold(body: Center(child: Text('Custom Route Screen'))),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(animation);
          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
      ),
    ),
  };

  /// Returns the enum's `values` list for [Rooute] mixin.
  @override
  List<MyRoutes> get valuesOf => values;
}
