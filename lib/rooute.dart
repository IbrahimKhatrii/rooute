/// A lightweight, strongly-typed routing framework for Flutter based on enums.
///
/// This library provides a minimal but powerful approach to navigation:
/// instead of string route names or large switch-cases, every route is expressed
/// as an enum value mixed with [Rooute]. Each enum case corresponds to a
/// concrete [RoouteBuilder], which constructs the underlying [Route].
///
/// ---
/// ## Core Concepts
///
/// ### 1. Enum-Driven Routing
/// Routes are defined as enum values:
///
/// ```dart
/// enum MyRoutes with Rooute<MyRoutes> {
///   home,
///   profile;
/// }
/// ```
///
/// Each enum entry corresponds to a navigation target.
/// The mixin adds ergonomic navigation helpers:
///
/// - `push()`
/// - `pushReplacement()`
/// - `pushForResult<T>()`
/// - `args<T>(context)`
/// - `name` → the canonical route ID
///
/// No more fragile string literals or massive routing tables.
///
/// ---
/// ## Route Builders
///
/// Each route is mapped to a [RoouteBuilder], which determines how the route
/// is constructed (Material, Cupertino, adaptive, or fully custom).
///
/// ```dart
/// @override
/// Map<MyRoutes, RoouteBuilder> get routes => {
///   home: RoouteBuilder.material(() => const HomePage()),
///   profile: RoouteBuilder.cupertino(() => const ProfilePage()),
/// };
/// ```
///
/// Builders can wrap:
/// - `MaterialPageRoute`
/// - `CupertinoPageRoute`
/// - Platform-adaptive transitions
/// - Any custom [Route] created via `PageRouteBuilder`
///
/// ---
/// ## Platform-Aware Navigation
///
/// `RoouteBuilder.adaptive` automatically chooses between Material and
/// Cupertino transitions depending on the platform:
///
/// ```dart
/// RoouteBuilder.adaptive(() => const SettingsPage());
/// ```
///
/// Internally this uses the `platformer` package to determine OS behavior.
///
/// ---
/// ## RoutableApp
///
/// [RoutableApp] wires your enum routes into Flutter's navigation system.
/// It removes the need to manually manage:
///
/// - `onGenerateRoute`
/// - `initialRoute`
/// - Centralized route registries
///
/// ```dart
/// RoutableApp(
///   launcher: MyRoutes.home,
///   builder: (initial, onGenerate) => MaterialApp(
///     initialRoute: initial,
///     onGenerateRoute: onGenerate,
///   ),
/// );
/// ```
///
/// ---
/// ## Files Included
///
/// This library is composed of several internal parts:
///
/// - `route.dart` → enum mixin + navigation helpers
/// - `app.dart` → [RoutableApp] implementation
/// - `builder.dart` → [RoouteBuilder] constructors
/// - `typedefs.dart` → callback typedefs
/// - `enums.dart` → internal enums (navigation types)
/// - `navigation.dart` → unified navigator wrappers
///
/// You normally never import these directly; importing `package:rooute/rooute.dart`
/// is sufficient.
///
/// ---
/// ## Highlights
///
/// - Strong route typing (no strings)
/// - Fully declarative routing table
/// - Consistent API surface (push, replace, args, results)
/// - Material, Cupertino, adaptive & custom transitions
/// - Cleaner structure than `onGenerateRoute` switch-cases
///
/// This entrypoint simply exposes all components required to build a complete,
/// strongly-typed routing system without boilerplate.
///
/// ---
library rooute;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformer/platformer.dart';

part 'src/route.dart';
part 'src/app.dart';
part 'src/builder.dart';
part 'src/typedefs.dart';
part 'src/enums.dart';
part 'src/navigation.dart';
