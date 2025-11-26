part of '../rooute.dart';

/// Signature for widget builder functions used by [RoouteBuilder].
///
/// Each route should provide a factory function that returns a fresh
/// widget instance whenever the route is pushed.
/// This avoids reusing old widget instances and ensures proper lifecycle
/// behavior.
///
/// Example:
/// ```dart
/// RoouteBuilder.material(() => HomePage());
/// RoouteBuilder.cupertino(() => ProfilePage());
/// ```
typedef RoouteWidgetFunction = Widget Function();
