# Rooute

**Author:** Ibrahim Khatrii
**GitHub:** [https://github.com/IbrahimKhatrii/rooute](https://github.com/IbrahimKhatrii/rooute)

A **lightweight, enum-centric routing framework for Flutter** that enables strongly-typed navigation without messy switch-cases or string-based route names. `Rooute` is designed for developers who want **clean, maintainable, and platform-adaptive routing**.

---

## Features

- **Strongly-typed routes using enums** – no more fragile string-based navigation.
- **Declarative mapping of enum → RouteBuilder** – define how each route should transition.
- **Platform-adaptive navigation** – automatically chooses Material or Cupertino transitions.
- **Custom transitions supported** – use `PageRouteBuilder` for slides, fades, or complex animations.
- **Convenient navigation helpers** – push, pushReplacement, pushAndRemoveUntil, pushForResult, etc.
- **Argument passing** – type-safe route arguments with easy retrieval via `RoutableApp.arguments<T>`.

---

## Installation

Add `rooute` to your `pubspec.yaml`:

```yaml
dependencies:
  rooute: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Define your routes

Create an enum that mixes in `Rooute<T>`:

```dart
enum MyRoutes with Rooute<MyRoutes> {
  launcher,
  home,
  customPage;

  @override
  Map<MyRoutes, RoouteBuilder> get routes => {
        launcher: RoouteBuilder.material(() => LauncherScreen()),
        home: RoouteBuilder.cupertino(() => Home()),
        customPage: RoouteBuilder.custom(
          (settings) => PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                CustomScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        ),
      };

  @override
  List<MyRoutes> get valuesOf => values;
}
```

---

### 2. Wrap your app with `RoutableApp`

```dart
void main() {
  runApp(
    RoutableApp(
      launcher: MyRoutes.launcher,
      builder: (initialRoute, onGenerateRoute) => MaterialApp(
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
```

---

### 3. Navigate between routes

```dart
// Push a route
MyRoutes.home.push(context, arguments: 'Hello Home');

// Push a route and get result
final result = await MyRoutes.customPage.pushForResult<String>(context);

// Push replacement
MyRoutes.home.pushReplacement(context);

// Push and remove until predicate
MyRoutes.launcher.pushAndRemoveUntil(context, (route) => route.isFirst);
```

---

### 4. Retrieve route arguments

```dart
final arg = RoutableApp.arguments<String>(context);
print(arg ?? 'No args');
```

---

## Route Types

`RoouteBuilder` supports multiple route types:

| Type        | Description                                                               |
| ----------- | ------------------------------------------------------------------------- |
| `material`  | Standard MaterialPageRoute transitions.                                   |
| `cupertino` | Standard CupertinoPageRoute transitions.                                  |
| `adaptive`  | Automatically uses Material or Cupertino based on platform.               |
| `custom`    | Fully custom `PageRoute` (use `PageRouteBuilder` for complex animations). |

---

## Advantages Over Traditional Routing

- No more long `switch-case` or `if-else` chains.
- All routes are **strongly-typed**.
- Easier to refactor route names without breaking code.
- Fully supports **argument passing** with type safety.
- Platform-adaptive transitions out-of-the-box.
- Centralized route definition and navigation helpers.

---

## Example Flow

1. `RoutableApp` sets `MyRoutes.launcher` as initial route.
2. `LauncherScreen` waits 1 second and pushes `MyRoutes.home`.
3. `Home` retrieves any arguments passed from the previous route.
4. Routes resolve automatically using enum-based mapping.
5. You can also create **custom transitions** with `PageRouteBuilder`.

---

## Example Project Structure

```
lib/
 ├─ rooute.dart
 ├─ src/
 │   ├─ app.dart
 │   ├─ builder.dart
 │   ├─ enums.dart
 │   ├─ navigation.dart
 │   ├─ route.dart
 │   └─ typedefs.dart
 └─ example.dart
```

---

## Author

Ibrahim Khatrii – passionate about **clean architecture, Dart, and Flutter**.
GitHub: [https://github.com/IbrahimKhatrii](https://github.com/IbrahimKhatrii)

---

## License

MIT License – see [LICENSE](https://github.com/IbrahimKhatrii/rooute/blob/main/LICENSE)

---

I can also create a **shorter, beginner-friendly version with screenshots, usage GIFs, and code snippets** ready for pub.dev if you want—it will make your package stand out more professionally.

Do you want me to do that next?
