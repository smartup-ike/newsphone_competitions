<p align="center">
  <img src="assets/icon.jpeg" alt="14614 Logo" width="200" />
</p>

<p align="center">
  A professional, feature-rich Flutter mobile application developed for Newsphone.gr serving as the client for ANT1 (App: 14614).
</p>
---

## 🌳 Git Branching Strategy

This project follows a streamlined branching model to manage development, testing, and production releases.

| Branch Name | Purpose | Status |
| :--- | :--- | :--- |
| **`dev`** | **Primary/Development Branch.** All new features, bug fixes, and general development work are integrated here. **This is the main branch developers should use** to create feature branches (`feature/X`, `bugfix/Y`). | Active Development |
| **`stage`** | **Staging/Internal Testing Branch.** Code from `dev` is merged here for internal QA, TestFlight (iOS), and Firebase App Distribution (Android). This branch should reflect the final release candidate. | Release Candidate |
| **`main`** | **Production Branch.** This branch is deployed live to the App Store and Google Play. It should always reflect the stable, production version of the app. Merges here should only happen after successful staging. | Production (Live) |

---

## 🏗️ Architecture & Design Patterns

This project is built using the **BLoC / Cubit Pattern (`flutter_bloc`)** following Clean Architecture principles. It enforces a strict layered dependency flow for separation of concerns, testability, and state predictability:

```
Services (HTTP / Firebase / Hive) ──> Cubits (State Management) ──> Presentation Views & Components
```

### Layer Responsibilities

* **Services (`lib/data/services/`):** Thin wrappers around external APIs, Firebase services, and persistent storage.
  * `ApiService`: Communicates with backend endpoints for contests, deals, categories, topics, auth, and user coupon history.
  * `NotificationService`: Manages Firebase Cloud Messaging (FCM) tokens, background notifications, and local notifications (`flutter_local_notifications`).
  * `AnalyticsService`: Logs user interaction events and screen navigation with Firebase Analytics.

* **Models (`lib/data/models/`):** Data transfer objects and Hive storage entities.
  * `Contest`, `Deal`, `ImageModel`, `Shows`, `ContestCategories`, `Topic`, `UserTransaction`.
  * `AppNotification`: Hive TypeAdapter (Type ID: 0) for persistent offline notification storage.

* **State Management / Logic (`lib/logic/blocs/`):** Feature-specific Cubits managing app state.
  * `ContestsCubit`: Fetches, filters (by special or category), and searches contests.
  * `DealsCubit`: Handles deals fetching and refresh cycles.
  * `CategoriesCubit`: Loads and manages contest categories.
  * `AuthCubit`: Handles Firebase authentication and backend registration.
  * `CouponsCubit`: Fetches coupon history and handles spending coupons.
  * `NotificationCubit`: Manages Hive notification box reading, topic subscriptions, and unread counts.

* **Presentation Layer (`lib/presentation/`):**
  * **Pages (`lib/presentation/pages/`):** Feature screens (`contests`, `deals`, `contest_content`, `coupons`, `notifications`, `preferences`, `settings`, `about`, `home`).
  * **Widgets (`lib/presentation/widgets/`):** Reusable components such as `ContestVideoPlayer`, `ButtonGradient`, and `BottomNavBar`.

---

## 📁 Project Structure

```
lib/
├── core/                        # App-wide design tokens, constants & utilities
│   ├── constans/                # Constant values and category extensions
│   ├── functions/               # Date/time formatting & Greek text utilities (toGreekUpperCase)
│   └── themes/                  # Theme colors, tokens & Roboto typography
├── data/                        # Core Data Layer
│   ├── models/                  # DTOs, Hive TypeAdapters, and JSON models
│   └── services/                # API client, Notification engine & Analytics
├── logic/                       # State Management (BLoC / Cubit)
│   └── blocs/                   # Feature Cubits (auth, categories, contest, coupons, deals, notifications)
├── presentation/                # UI Presentation Layer
│   ├── pages/                   # App screens grouped by feature
│   │   ├── about/               # App information screen
│   │   ├── contest_content/     # Detailed contest view, header, and SMS/call details
│   │   ├── contests/            # Contests feed, media carousel, and category filters
│   │   ├── coupons/             # User coupon history, sign-in, and reward claims
│   │   ├── deals/               # Deals feed, cards with media carousels, and bottom sheets
│   │   ├── home/                # Bottom navigation container and main view
│   │   ├── notifications/       # Push notification inbox and unread status
│   │   ├── preferences/         # User topic preference selections
│   │   ├── settings/            # App options and preferences
│   │   └── terms_page/          # Terms and privacy policy
│   └── widgets/                 # Reusable UI components (ContestVideoPlayer, ButtonGradient, BottomNavBar)
├── firebase_options.dart        # Auto-generated Firebase cross-platform configuration
└── main.dart                    # Global MultiBlocProvider, Hive init, and app entry point
```

---

## 🛠️ Tech Stack & Key Dependencies

The application leverages production-ready Flutter packages:

| Category | Package | Purpose |
| :--- | :--- | :--- |
| **State Management** | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | Cubit-based reactive state management |
| | [`equatable`](https://pub.dev/packages/equatable) | Value equality comparison for state objects |
| **Networking** | [`http`](https://pub.dev/packages/http) | HTTP client for REST API communication |
| **Firebase Suite** | `firebase_core`, `firebase_messaging`, `firebase_analytics`, `firebase_auth` | Auth, Cloud Messaging (FCM), and Analytics |
| **Local Storage** | [`hive`](https://pub.dev/packages/hive) & [`hive_flutter`](https://pub.dev/packages/hive_flutter) | Fast NoSQL key-value database for offline notification storage |
| | [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Persistent key-value storage for local user settings |
| **Media & UI** | [`video_player`](https://pub.dev/packages/video_player) | Embedded video playback with auto-play and fullscreen support |
| | [`flutter_cache_manager`](https://pub.dev/packages/flutter_cache_manager) | Local video and asset disk caching |
| | [`google_fonts`](https://pub.dev/packages/google_fonts) | Typography system using Google Fonts (Roboto) |
| | [`flutter_svg`](https://pub.dev/packages/flutter_svg) | Vector graphics rendering |
| | [`transparent_image`](https://pub.dev/packages/transparent_image) | Smooth placeholder image loading |
| | [`shimmer`](https://pub.dev/packages/shimmer) | Loading shimmer skeleton effect |
| **Notifications** | [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) | Local device notifications handling |
| **Utilities** | [`intl`](https://pub.dev/packages/intl) | Date, time, and currency formatting |
| | [`url_launcher`](https://pub.dev/packages/url_launcher) | External URL opening and call/SMS integration |
| | [`package_info_plus`](https://pub.dev/packages/package_info_plus) | Application version info retrieval |

---

## 🤖 AI Development Instructions

If you are developing or maintaining this codebase using an **AI coding assistant**, please adhere to the following rules:

1. **State Management**: Always use Cubits under `lib/logic/blocs/`. Do not introduce raw `setState` for global or cross-screen business logic.
2. **Typography**: All app text styles must consume `NewsphoneTypography` or `GoogleFonts.roboto`.
3. **Greek Language Rules**: When converting strings to uppercase for display, always use `.toGreekUpperCase()` from `lib/core/functions/greek_utils.dart` to strip accents according to Greek grammar rules.
4. **Media Handling**: All video rendering in contest or deal carousels must utilize `ContestVideoPlayer`.
5. **No Direct Service Calls in Views**: Views should emit intent through Cubits or call `ApiService` via Cubit methods rather than instantiating services directly inside widgets.

---

## ⚙️ Project Configuration & Common Tasks

### 1. API Configuration
The app interacts with the backend REST API configured in [`lib/data/services/api_service.dart`](file:///Users/dmilios/Documents/GitHub/newsphone_competitions/lib/data/services/api_service.dart):
* **Production API Base URL**: `https://newsphone-api-560508338889.europe-central2.run.app`

### 2. Admin Dashboard
The web management interface for managing contests, deals, coupons, and push notifications:
* **Dashboard URL**: [https://newphone-test.web.app/](https://newphone-test.web.app/)

### 3. Code Generation (Hive Adapters)
When modifying Hive data models like `AppNotification` in `lib/data/models/notification.dart`, re-generate the TypeAdapters:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Launcher Icons & Splash Screen
If you update app icons or splash screen settings inside `pubspec.yaml`, run:
* **Launcher Icons Generator**:
  ```bash
  flutter pub run flutter_launcher_icons
  ```
* **Native Splash Screen Generator**:
  ```bash
  flutter pub run flutter_native_splash:create
  ```

### 5. iOS CocoaPods Setup
When initializing the iOS project or updating native dependencies:
```bash
cd ios && pod install
```

### 6. Running & Testing
To run the app locally:
```bash
flutter pub get
flutter run
```
To execute static code analysis:
```bash
flutter analyze
```
