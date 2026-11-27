# Apps (flavors)

One codebase, one backend, several store apps. Each app is named by its **number**
and is built as a *flavor*. The TV channel (ANT1, OPEN, …) is just a setting of the app.
The screens are the same for every app; only the values below change.

| Flavor     | Number | Channel | Android id          | iOS bundle id    | Theme |
| :--------- | :----- | :------ | :------------------ | :--------------- | :---- |
| `app14614` | 14614  | ANT1    | `com.akep.app14614` | `com.akep.14614` | light (blue) |
| `app14800` | 14800  | OPEN    | `com.akep.app14800` | `com.akep.14800` | dark (orange) |

## Run / build

`--flavor` is required.

```bash
flutter run --flavor app14614
flutter run --flavor app14800

flutter build appbundle --flavor app14614
flutter build ipa --flavor app14614
```

## Where each app's things live

```
lib/flavors/
  flavor_config.dart        what an app is (number, name, channel, logos, colors, terms, Firebase)
  app_colors.dart           the color template: one color per ROLE (scaffold, surface, textPrimary…)
  dark_material_theme.dart  Material defaults for dark apps
  all_flavors.dart          list of all apps (one line per app)
  app14614/                 14614: config + colors, terms, firebase_options.dart
  app14800/                 14800: config + colors, terms
flavors/
  app14614/bundled/         logos shipped inside the 14614 app only
  app14614/source/          icon + splash source images (not shipped)
  app14800/bundled/         …same for 14800
  app14800/source/
flutter_launcher_icons-app14800.yaml   icon settings for 14800
flutter_native_splash-app14800.yaml    splash settings for 14800
tool/generate_app_images.py            draws the number icon/splash/logo for a new app
test/flavors/                          proves 14614's colors never change by accident
```

Platform files that must live in fixed places (generated or per platform):

| What | Where |
| :--- | :--- |
| Android app id, name, signing | `android/app/build.gradle.kts` → `productFlavors` |
| Android Firebase config | `android/app/src/<flavor>/google-services.json` |
| Android icon + splash (generated) | `android/app/src/<flavor>/res/` (14614 uses `src/main/res`) |
| Android release key | 14614: `android/release-key.jks`; others: `android/keystores/` (**not in git, back it up!**) |
| iOS bundle id, name, icon, splash | Build configurations `Debug/Release/Profile-<flavor>` + schemes `app14614`, `app14800` |
| iOS Firebase config | `ios/config/<flavor>/GoogleService-Info.plist` (copied in by a build phase) |

## Colors

Screens never use raw colors. They use `NewsphoneTheme.<role>`, e.g.
`NewsphoneTheme.surface`, `NewsphoneTheme.textPrimary`, `NewsphoneTheme.primary`.
Each app fills in **every role** in its `colors:` block, so an app can be light or dark
without touching any screen. Only video overlays and toasts use fixed colors.

**14614 must never change.** `test/flavors/app14614_unchanged_test.dart` fails if any 14614
color changes. Run `flutter test` before merging.

## Firebase

Both apps use the **same Firebase project** (`newphone-test`), each with its own Android and
iOS app registered in it. The backend keeps users and coupons apart per app (`X-Brand`).

| App | Android config | iOS config | Dart options |
| :-- | :-- | :-- | :-- |
| 14614 | `android/app/src/app14614/google-services.json` | `ios/config/app14614/GoogleService-Info.plist` | `lib/flavors/app14614/firebase_options.dart` |
| 14800 | `android/app/src/app14800/google-services.json` | `ios/config/app14800/GoogleService-Info.plist` | `lib/flavors/app14800/firebase_options.dart` |

An app with `firebaseOptions: null` runs without Firebase (no login, coupons, push, analytics).

For Android phone login, every signing key must be added to the Firebase Android app
(Project settings → Your apps → SHA certificates): the debug key, the upload key in
`android/keystores/`, and the **Play App Signing key** (Play Console → Test and release →
App integrity) once the first build is uploaded. For iOS push, upload the APNs key to the
iOS app in Firebase (Project settings → Cloud Messaging).

If an app later moves to its own Firebase project, run `flutterfire configure` with that
project and the paths above.

## Backend

Every request sends `X-Brand: <appId>` (`14614`, `14800`), from `_headers()` in
`lib/data/services/api_service.dart`. The backend returns that app's contests, deals, users
and coupons. No header means 14614; an unknown value is rejected (400).

### Station numbers and topic (`GET /brand`)

The call number, SMS number and notification topic come from `GET /brand`, so Newsphone can
change them on the server without an app update (`lib/data/services/brand_service.dart`):

1. On start the app uses the values saved last time (the flavor's `phoneNumber` /
   `notificationsTopic` on the very first run) and subscribes to that topic.
2. In the background it calls `/brand`. A good answer for **this** app is saved and used;
   if the topic changed, the app moves its subscription.
3. If the request fails (offline, old backend without `/brand`), nothing changes.

Use `BrandService.current.callNumber` / `.smsNumber` / `.generalTopic` in the code, not the
flavor values. The SMS line of the contest instructions shows the SMS number only when it
differs from the call number.

## Environments (production / staging)

Production is the default; normal `flutter run` / `flutter build` need no flags.
To test against another backend, use a local env file (git-ignored, never committed):

```bash
cp env/staging.example.json env/staging.json   # then put the real staging URL in it
flutter run --flavor app14800 --dart-define-from-file=env/staging.json
```

- A non-production build shows a red **STAGING** ribbon in the top-right corner.
- **Release builds always use production**, even if an env file is passed
  (`lib/core/config/app_env.dart`). A staging URL can never reach the stores.

## Add a new number (example: 14900, channel XYZ)

1. **Dart**: copy `lib/flavors/app14800/` to `lib/flavors/app14900/`, rename the variable to
   `app14900`, and set number, name, channel, topic, logos, colors and terms.
   Add one line to `lib/flavors/all_flavors.dart`.
2. **Images**: put the channel logo in `flavors/app14900/bundled/station_logo.(png|svg)` and run
   ```bash
   python3 tool/generate_app_images.py --number 14900 --background "#xxxxxx" \
     --foreground "#xxxxxx" --font <Montserrat-Italic.ttf> --out flavors/app14900
   ```
   Add the `flavors/app14900/bundled/` folder to `pubspec.yaml` (copy the 14800 entry).
3. **Android**: add a `create("app14900")` block in `productFlavors` (`build.gradle.kts`) and
   create its keystore in `android/keystores/` (see the 14800 entry).
4. **iOS**: add the `Debug/Release/Profile-app14900` build configurations and an `app14900`
   scheme (duplicate the 14800 ones in Xcode), with its bundle id, `APP_DISPLAY_NAME`,
   `AppIcon-app14900` and `LaunchScreenApp14900`.
5. **Icon + splash**: copy the two `*-app14800.yaml` files to `*-app14900.yaml`, change the paths
   and colors, then run
   ```bash
   dart run flutter_launcher_icons
   dart run flutter_native_splash:create --flavor app14900
   ```
6. **Stores**: create the app in App Store Connect / Google Play; register the bundle ids
   (`com.akep.14900` and `com.akep.14900.n14900` for the notification extension).

## Before releasing 14800

- [x] Dark color palette approved (based on tvopen.gr). Update `app14800.dart` if a final brand palette arrives.
- [ ] Real 14800 terms (currently a copy of 14614's with number/channel swapped).
- [x] Firebase: same project as 14614 for now (see above). Add the Play App Signing SHA and the APNs key.
- [ ] Backend separates 14614 / 14800 data: done on staging (`X-Brand`), production pending.
- [ ] App Store Connect + Google Play apps created.

## Store screenshots

Build with made-up contests and deals (no backend data, no other channel's names):

```bash
# logos for the demo deals, served from this Mac
python3 -m http.server 8095 --bind 127.0.0.1 --directory flavors/app14800/store/demo_logos
adb reverse tcp:8095 tcp:8095        # Android emulator only

flutter run --flavor app14800 --dart-define=DEMO_DATA=true
```

The fake data is in `lib/data/demo/demo_data.dart` (photos from Unsplash). Without
`DEMO_DATA=true` it is never used. Raw screenshots and the Mokuply project live in
`flavors/app14800/store/`.
