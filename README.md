
# flutter_core_utils Package

A modular Flutter package for scalable app development, featuring:
- Dependency injection (GetIt)
- Secure storage
- Firebase integration
- Networking (Dio)
- Bloc state management
- Localization
- Theming
- Notification handling
- Reusable widgets

## Features
- **DI & Core Utilities:** Easy setup and access to services via GetIt.
- **Networking:** Dio-based API layer with interceptors and error handling.
- **Firebase:** Auth, Firestore, Messaging, Analytics, Crashlytics.
- **Notifications:** FCM and local notifications with unified service.
- **State Management:** Bloc observer for debugging and lifecycle tracking.
- **Theming:** Light/dark theme support and centralized theme management.
- **Localization:** Built-in i18n support.
- **Reusable Widgets:** Custom buttons, text fields, snack bars, etc.


## Firebase Setup

1. Create a Firebase project.
2. Register your app (Android/iOS).
3. Download `google-services.json` / `GoogleService-Info.plist`.
4. Run `flutterfire configure` to generate `firebase_options.dart`.
5. Initialize Firebase in your app:

```dart
await FirebaseInitializer.init(options: DefaultFirebaseOptions.currentPlatform);
```

## Getting Started
1. Add the package to your `pubspec.yaml`.
2. Initialize Firebase in `main.dart`:
	```dart
	// if need firebase
	await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
	```
3. Set up DI:
	```dart
	// Must
	await locatorSetup();
	```
4. Use services via DI:
	```dart
	locator<ApiServices>().getRequest(...);
	locator<NotificationService>().init(...);
	```

## Folder Structure
```
lib/
├── main.dart                 # App entry point
├── app.dart                  # MyApp widget
├── core/                     # Core utilities, DI, base classes
│   ├── di.dart               # GetIt setup
│   ├── failures.dart         # Error types
│   ├── bloc_observer.dart    # Bloc observer
│   ├── secure_storage.dart   # Secure storage wrapper
│   └── firebase_services.dart # Firebase service abstraction
├── shared/                   # Reusable components
│   ├── reusable_widgets/     # Widgets used across app
│   └── l10n/                 # Localization
├── network/                  # Networking layer
│   ├── api_endpoints.dart
│   ├── api_services.dart
│   └── dio_factory.dart
├── notification/             # FCM & local notifications
│   └── fcm_service.dart
├── theme/                    # Theme management
│   ├── app_theme.dart
│   ├── dark_theme.dart
│   └── light_theme.dart
├── navigation/               # Routing
│   ├── app_router.dart
│   └── app_routes.dart
├── src/                      # Internal implementation (optional)
│   └── ...
└── index.dart                # Barrel file exporting public API
```

## Example Usage
```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// if need firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await locatorSetup();
  runApp(const MyApp());
}
```

## Documentation
- Each service and utility is documented in code with Dart doc comments.
- See the barrel file (`index.dart`) for all public exports.
- For advanced usage, see the source files in each folder.

## Contributing
Pull requests and issues are welcome!

## License
MIT
