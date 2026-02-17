# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

COGO (Coffee Go) is a Flutter mobile app for mentor/mentee coffee chat matching. Built with Dart 3.8.1 / Flutter 3.32.8, targeting iOS, Android, and Web. The project uses Korean for comments, commit messages, and UI text.

## Common Commands

```bash
flutter run                          # Run the app (device/emulator)
flutter build apk                   # Build Android APK
flutter build ios                   # Build iOS
flutter analyze                     # Static analysis (flutter_lints)
flutter test                        # Run all tests
dart run build_runner build          # Generate Freezed/JSON code
dart run build_runner build --delete-conflicting-outputs  # Regenerate from scratch
```

## Architecture

**MVVM + Clean Architecture** with Provider for state management.

### Layer Structure

- **`lib/features/`** — Feature modules (auth, home, cogo, chat, mypage), each containing screens (`*_screen.dart`) and view models (`*_view_model.dart` extending `ChangeNotifier`)
- **`lib/data/`** — Data layer: services (`*_service.dart` wrapping Dio API calls), DTOs (`data/dto/request/`, `data/dto/response/` using Freezed), repository (local storage via SharedPreferences/FlutterSecureStorage)
- **`lib/domain/entity/`** — Business entities separate from DTOs
- **`lib/common/`** — Shared widgets (atomic design: `widgets/atoms/` → `widgets/components/`), enums, utilities
- **`lib/constants/`** — App-wide constants exported via barrel file: `CogoColor`, `CogoTextStyle` (Pretendard font), `Paths` (routes), `Apis` (endpoints)
- **`lib/route/routes.dart`** — GoRouter config with `StatefulShellRoute` for bottom tab navigation

### Key Patterns

- **DI**: GetIt service locator (`lib/data/di/get_it_locator.dart`) — services registered as lazy singletons, view models as factories
- **Global Providers**: Six `ChangeNotifierProvider`s created in `main.dart` (Home, Cogo, Chat, Mypage, BottomNavigation, Splash)
- **API Client**: Singleton Dio wrapper (`lib/data/di/api_client.dart`) with interceptors for JWT token management and automatic 401 refresh
- **Real-time Chat**: STOMP WebSocket (`wss://back-coffeego.com/ws`)
- **DTOs**: Freezed immutable classes with `@JsonSerializable` — after modifying any DTO, run `dart run build_runner build`
- **API Endpoints**: Defined in `lib/constants/apis.dart` — naming convention is `verb+Object` (e.g., `getGoogleAccessToken`, `saveImage`)
- **Web fallback**: `kIsWeb` checks throughout for platform-specific behavior (no `.env` loading, no splash, viewport constrained to 320-430px)

### Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Screen | `*_screen.dart` | `login_screen.dart` |
| ViewModel | `*_view_model.dart` | `login_view_model.dart` |
| Service | `*_service.dart` | `auth_service.dart` |
| Request DTO | `*_request.dart` | `signup_request.dart` |
| Response DTO | `*_response.dart` | `login_response.dart` |
| Entity | `*_entity.dart` | `user_entity.dart` |

## Environment

The app loads configuration from `.env` (mobile only). Base URL: `https://back-coffeego.com/`. Token storage uses `FlutterSecureStorage`.
