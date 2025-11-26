part of '../rooute.dart';

/// Represents the type of navigation transition used by a [RoouteBuilder].
///
/// This enum indicates how the page transition should appear when
/// a route is pushed or replaced. It helps the routing system determine
/// whether to use Material, Cupertino, or adaptive styling.
enum RoouteNavigationType {
  /// Use Material-style transitions (e.g., slide from right on Android).
  material,

  /// Use Cupertino-style transitions (e.g., slide from right with iOS animation).
  cupertino,

  /// Automatically choose the transition based on the current platform:
  /// - Cupertino for iOS/macOS
  /// - Material for Android, Web, Windows, Linux
  adaptive,
}
