part of '../rooute.dart';

/// Provides convenient navigation helpers for enum-based routes.
///
/// This extension adds methods to any enum that mixes in [Rooute],
/// allowing you to push, replace, or remove routes directly using enum values
/// rather than string route names.
/// All methods internally use Flutter's [Navigator] API.
///
/// Example:
/// ```dart
/// MyRoutes.home.push(context, arguments: 'Hello');
/// final result = await MyRoutes.home.pushForResult<int>(context);
/// ```
extension RoouteNavX<T extends Enum> on Rooute<T> {
  /// Pushes the current route onto the navigation stack.
  ///
  /// - [context]: The build context used to find the navigator.
  /// - [arguments]: Optional arguments passed to the route.
  /// Returns a [Future] that completes when the pushed route is popped.
  Future<dynamic> push(BuildContext context, {Object? arguments}) =>
      Navigator.of(context).pushNamed(name, arguments: arguments);

  /// Pushes the current route and expects a result of type [R] when the route is popped.
  ///
  /// Example:
  /// ```dart
  /// final int? result = await MyRoutes.form.pushForResult<int>(context);
  /// ```
  Future<R?> pushForResult<R>(BuildContext context, {Object? arguments}) =>
      Navigator.of(context).pushNamed<R>(name, arguments: arguments);

  /// Replaces the current route with this route.
  ///
  /// The current route is removed and replaced by this enum route.
  Future<dynamic> pushReplacement(BuildContext context, {Object? arguments}) =>
      Navigator.of(context).pushReplacementNamed(name, arguments: arguments);

  /// Replaces the current route with this route and returns a result of type [R].
  ///
  /// - [result]: Optional result to send back to the previous route.
  /// Returns a [Future<R?>] that completes with the result from the replaced route.
  Future<R?> pushReplacementForResult<R>(
    BuildContext context, {
    Object? arguments,
    R? result,
  }) => Navigator.of(context)
      .pushReplacementNamed<Object?, R>(
        name,
        arguments: arguments,
        result: result,
      )
      .then((value) => value as R?);

  /// Pushes the current route and removes routes until [predicate] returns true.
  ///
  /// - [predicate]: Function that determines which routes remain in the stack.
  /// - [arguments]: Optional arguments passed to the new route.
  Future<dynamic> pushAndRemoveUntil(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) => Navigator.of(
    context,
  ).pushNamedAndRemoveUntil(name, predicate, arguments: arguments);

  /// Pushes the current route and clears the entire navigation stack.
  ///
  /// Equivalent to `pushNamedAndRemoveUntil` with a predicate that always returns false.
  Future<dynamic> pushAndClearStack(
    BuildContext context, {
    Object? arguments,
  }) => Navigator.of(
    context,
  ).pushNamedAndRemoveUntil(name, (_) => false, arguments: arguments);

  /// Makes the current route the root of the navigation stack.
  ///
  /// Functionally identical to [pushAndClearStack].
  /// Useful for scenarios like authentication flows where you want to
  /// reset the stack and prevent users from going back.
  Future<dynamic> makeRoot(BuildContext context, {Object? arguments}) =>
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(name, (_) => false, arguments: arguments);
}
