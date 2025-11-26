// ignore_for_file: comment_references

part of '../rooute.dart';

/// Encapsulates a route constructor for enum-based navigation.
///
/// [RoouteBuilder] determines *how* a route should be created and presented,
/// wrapping platform-specific transitions or custom animations.
/// Each enum route should map to a [RoouteBuilder] in its `routes` map.
///
/// Typical usage:
/// ```dart
/// enum MyRoutes with Rooute<MyRoutes> {
///   home,
///   profile;
///
///   @override
///   Map<MyRoutes, RoouteBuilder> get routes => {
///     home: RoouteBuilder.material(() => HomePage()),
///     profile: RoouteBuilder.cupertino(() => ProfilePage()),
///   };
///
///   @override
///   List<MyRoutes> get valuesOf => values;
/// }
/// ```
class RoouteBuilder {
  /// A factory function that receives [RouteSettings] and returns a [Route].
  ///
  /// This ensures that `settings.arguments` and other properties are
  /// correctly propagated to the underlying route.
  final Route<dynamic> Function(RouteSettings settings) _factory;

  /// The type of navigation transition this builder represents.
  ///
  /// Helps indicate whether the route uses Material, Cupertino, or adaptive
  /// styling. Primarily informational for platform-aware transitions.
  final RoouteNavigationType type;

  /// Private constructor for internal use.
  const RoouteBuilder._(
    this._factory, {
    this.type = RoouteNavigationType.adaptive,
  });

  /// Creates a Material-style route.
  ///
  /// Example:
  /// ```dart
  /// RoouteBuilder.material(() => HomePage());
  /// ```
  factory RoouteBuilder.material(RoouteWidgetFunction build) => RoouteBuilder._(
    (settings) =>
        MaterialPageRoute(builder: (context) => build(), settings: settings),
    type: RoouteNavigationType.material,
  );

  /// Creates a Cupertino-style route.
  ///
  /// Example:
  /// ```dart
  /// RoouteBuilder.cupertino(() => ProfilePage());
  /// ```
  factory RoouteBuilder.cupertino(RoouteWidgetFunction build) =>
      RoouteBuilder._(
        (settings) => CupertinoPageRoute(
          builder: (context) => build(),
          settings: settings,
        ),
        type: RoouteNavigationType.cupertino,
      );

  /// Creates a platform-adaptive route.
  ///
  /// Uses Cupertino-style routes on iOS/macOS and Material-style routes
  /// on other platforms (Android, Web, Windows, Linux).
  ///
  /// Example:
  /// ```dart
  /// RoouteBuilder.adaptive(() => SettingsPage());
  /// ```
  factory RoouteBuilder.adaptive(RoouteWidgetFunction build) {
    final cupertino = RoouteBuilder.cupertino(build);
    final material = RoouteBuilder.material(build);
    return Platformer.isIOS || Platformer.isMacOS ? cupertino : material;
  }

  /// Creates a custom route using a factory function.
  ///
  /// This allows full control over the route, including animations, transitions,
  /// and page builders. The factory receives the runtime [RouteSettings].
  ///
  /// Example:
  /// ```dart
  /// RoouteBuilder.custom((settings) => PageRouteBuilder(
  ///       settings: settings,
  ///       pageBuilder: (ctx, anim, secAnim) => CustomScreen(),
  ///       transitionsBuilder: (ctx, anim, secAnim, child) => FadeTransition(
  ///         opacity: anim,
  ///         child: child,
  ///       ),
  ///     ));
  /// ```
  factory RoouteBuilder.custom(
    Route<dynamic> Function(RouteSettings settings) routeFactory,
  ) => RoouteBuilder._(routeFactory);

  /// Builds the route for a given [RouteSettings].
  ///
  /// This is called internally by the routing system when the enum route
  /// is pushed, replaced, or presented.
  Route<dynamic> build(RouteSettings settings) => _factory(settings);
}
