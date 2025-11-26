// ignore_for_file: comment_references

part of '../rooute.dart';

/// A wrapper widget that integrates enum-based routing into a Flutter app.
///
/// [RoutableApp] eliminates the need to manually wire `onGenerateRoute` or
/// track the initial route inside [MaterialApp] or [CupertinoApp].
/// It automatically binds an enum that mixes in [Rooute] to the app's routing.
///
/// ## Type Parameters
///
/// - `E extends Rooute` → the enum type representing all routes.
///
/// ## Example Usage
///
/// ```dart
/// enum AppRoutes with Rooute<AppRoutes> {
///   home,
///   login;
///
///   @override
///   List<AppRoutes> get valuesOf => values;
///
///   @override
///   Map<AppRoutes, RoouteBuilder> get routes => {
///     home: RoouteBuilder.material(() => HomePage()),
///     login: RoouteBuilder.cupertino(() => LoginPage()),
///   };
/// }
///
/// void main() {
///   runApp(
///     RoutableApp(
///       launcher: AppRoutes.home,
///       builder: (initialRoute, onGenerateRoute) => MaterialApp(
///         initialRoute: initialRoute,
///         onGenerateRoute: onGenerateRoute,
///       ),
///     ),
///   );
/// }
/// ```
class RoutableApp<E extends Rooute> extends StatelessWidget {
  /// The initial route for the application.
  ///
  /// Must be a value from your enum that mixes in [Rooute].
  final E launcher;

  /// A builder that constructs the root application widget (MaterialApp/CupertinoApp).
  ///
  /// Receives:
  /// - [initialRoute] → the `.name` of the enum route to start with.
  /// - [onGenerateRoute] → a function that resolves a route from [RouteSettings]
  ///   using the enum-based routing table.
  final Widget Function(
    String initialRoute,
    Route<dynamic>? Function(RouteSettings settings) onGenerateRoute,
  )
  builder;

  /// Creates a [RoutableApp] bound to an enum route launcher.
  const RoutableApp({required this.launcher, required this.builder, super.key});

  @override
  Widget build(BuildContext context) => builder(
    launcher.name,
    (settings) => Rooute._generate(settings, launcher),
  );

  /// Retrieves strongly-typed arguments passed through the route.
  ///
  /// Example:
  /// ```dart
  /// final message = RoutableApp.arguments<String>(context);
  /// ```
  /// Returns `null` if the argument type does not match.
  static T? arguments<T>(BuildContext context) {
    final settings = ModalRoute.of(context)?.settings;
    final value = settings?.arguments;
    return value is T ? value : null;
  }
}
