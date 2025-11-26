# Changelog

All notable changes to this project will be documented in this file.

## [0.0.3]

### Added

- Initial release of **rooute**, a lightweight, enum-centric routing framework for Flutter.
- Strongly-typed enum routes using the `Rooute` mixin.
- Platform-adaptive navigation:
  - Material transitions on Android/Windows/Linux/Web.
  - Cupertino transitions on iOS/macOS.
  - Adaptive transitions automatically based on platform.
- Custom route support using `PageRouteBuilder` or any advanced route type.
- `RoutableApp` widget to automatically wire enum-based routes to `MaterialApp` or `CupertinoApp`.
- Easy navigation helpers on enum values:
  - `push`, `pushReplacement`, `pushForResult`, `pushReplacementForResult`, `pushAndRemoveUntil`, `pushAndClearStack`, `makeRoot`.
- Type-safe argument passing using `RoutableApp.arguments<T>(context)`.
- Detailed documentation and usage example provided.

### Fixed

- N/A — first release.

### Notes

- Author: **Ibrahim Khatrii**
- GitHub: [https://github.com/IbrahimKhatrii/rooute](https://github.com/IbrahimKhatrii/rooute)
- License: MIT
