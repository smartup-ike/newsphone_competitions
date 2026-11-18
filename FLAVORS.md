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

An app without `firebaseOptions` (currently 14800) runs **without Firebase**: no login,
coupons, push notifications or analytics. It still builds and every screen works.

To turn Firebase on for an app (example 14800, once the project is decided):

```bash
flutterfire configure \
  --project=<firebase-project-id> \
  --out=lib/flavors/app14800/firebase_options.dart \
  --android-package-name=com.akep.app14800 \
  --ios-bundle-id=com.akep.14800 \
  --android-out=android/app/src/app14800/google-services.json \
  --ios-out=ios/config/app14800/GoogleService-Info.plist \
  --ios-build-config=Release-app14800
```

Then rename the generated class to `App14800FirebaseOptions` and set
`firebaseOptions: () => App14800FirebaseOptions.currentPlatform` in `app14800.dart`.
Also set `GOOGLE_REVERSED_CLIENT_ID` for the `*-app14800` iOS configs (Xcode → Runner →
Build Settings → User-Defined) and enable Phone sign-in in Firebase Auth.

## Backend

The app does **not** send an app id yet. When the backend is ready, add it in one place:
`_headers()` in `lib/data/services/api_service.dart` (`FlavorConfig.instance.appId`).

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
- [ ] Firebase decided and configured (see above).
- [ ] Backend separates 14614 / 14800 data.
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
