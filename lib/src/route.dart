part of '../rooute.dart';

/// Mixin for defining strongly-typed enum-based routes.
///
/// Any enum that mixes in [Rooute] gains a strongly-typed routing system.
/// Each enum value represents a logical route and maps to a [RoouteBuilder]
/// that constructs the actual [Route] object.
///
/// ## Usage:
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
/// ```
mixin Rooute<T extends Enum> implements Enum {
  /// Returns the list of enum values for this route.
  ///
  /// Required because generic enums cannot automatically access `.values`.
  List<T> get valuesOf;

  /// Maps each enum value to a [RoouteBuilder].
  ///
  /// Defines the actual route creation logic for each enum case.
  Map<T, RoouteBuilder> get routes;

  /// Generates a [Route] for the given [RouteSettings].
  ///
  /// This is used internally by [RoutableApp] to resolve the enum route
  /// into a Flutter [Route] instance.
  ///
  /// - [settings] → RouteSettings received from the navigator
  /// - [defaultRoute] → the enum instance used as fallback
  ///
  /// Returns a fully constructed [Route] or `null` if not found.
  static Route<dynamic>? _generate<E extends Rooute>(
    RouteSettings settings,
    E defaultRoute,
  ) {
    final values = defaultRoute.valuesOf;
    final routes = defaultRoute.routes;

    // Find the enum value that matches the route name, or fallback to default
    final found = values.firstWhere(
      (v) => v.name == settings.name,
      orElse: () => defaultRoute,
    );

    // Resolve the builder from the map, fallback if missing
    final builder = routes[found] ?? defaultRoute._resolve(defaultRoute)!;

    return builder.build(settings);
  }

  /// Resolves the [RoouteBuilder] for a given enum value.
  ///
  /// Returns `null` if the value is not defined in [routes].
  RoouteBuilder? _resolve(T value) => routes[value];
}
