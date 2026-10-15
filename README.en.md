# MPI Brasil

[Português](README.md)

A Flutter app that helps health professionals prescribe medication for older
patients. It provides information on potentially inappropriate medications
(MPI in Portuguese) to support clinical decision-making.

The app still calls Firebase Realtime Database (`mpibrasil.firebaseio.com`)
and Firebase Authentication through Identity Toolkit directly. The backend
replacement is in progress; starting the local backend does not redirect app
requests. The plan and contracts live in `docs/contracts/` in the MPI Brasil
workspace, outside this repository.

## Requirements

- For development: mise and the tools in `mise.toml`: Flutter 3.41,
  Java OpenJDK 17, and `android-sdk = "20"`.
- For Android: Android SDK and a configured device or emulator.
- For iOS: macOS with Xcode and a configured iOS environment.
- To build and serve only the web version: Docker with Docker Compose;
  Flutter does not need to be installed on the host.

## Running

### 1. Clone the repository and prepare the environment

With mise installed and activated in your shell:

```sh
mkdir -p ~/repos
git clone -b develop https://github.com/institutosocialtech/mpi-brasil.git ~/repos/mpibrasil
cd ~/repos/mpibrasil
mise trust
mise install
```

To prepare the Android components declared by the repository task:

```sh
mise run sdk:install
```

This task calls `sdkmanager` to install build-tools 28.0.3, platform-tools,
tools, and platforms;android-36. Check your platform environment with
`flutter doctor` before building.

### 2. Dependencies and code generation

```sh
flutter pub get
dart run intl_utils:generate
```

Translations live in `lib/l10n/*.arb`; localization code is generated in
`lib/generated/` (ignored by Git). After changing JSON models or annotated
providers, also regenerate the `.g.dart` files:

```sh
dart run build_runner build --delete-conflicting-outputs
```

The `.g.dart` files in `lib/models/` and `lib/providers/` are tracked.
Review and include the corresponding generated changes in your PR.

### 3. Run in debug mode

```sh
flutter devices
flutter run --debug -d <device-id>
```

Replace `<device-id>` with an identifier from `flutter devices`.
For web with WebAssembly:

```sh
flutter run -d chrome --wasm
```

### 4. Build in debug mode

Run the command for your target platform with its environment configured:

```sh
flutter build apk --debug
flutter build ios --debug
flutter build web --debug --wasm
```

The iOS build depends on the macOS/Xcode environment and signing configuration.
TODO: document provisioning and distribution for Android/iOS releases.

### 5. Web with Docker

```sh
docker compose up --build
```

Open `http://localhost:8080`. Compose uses `docker/Dockerfile`, downloads Flutter
3.41.9, generates translations, builds with `flutter build web --release --wasm`,
and serves the result with Caddy. To build the image only:

```sh
docker compose build
```

The image is `mpibrasil-flutter:<version>`, with its tag defined in `compose.yaml`.
The Dockerfile does not run `build_runner`: keep the tracked `.g.dart` files current.

The WebAssembly build requires the `Cross-Origin-Opener-Policy: same-origin` and
`Cross-Origin-Embedder-Policy: require-corp` headers configured in `docker/Caddyfile`.
Preserve these response headers when placing another proxy in front of Caddy.

The domains planned in the workspace infrastructure draft are
`app.mpibrasil.dev` and `app.staging.mpibrasil.dev`. This does not confirm an active
deployment. TODO: document the deployment workflow once it is defined.

## Version

The version lives in `VERSION`, `pubspec.yaml`, and the image tag in `compose.yaml`.
To update all three together, preserving the pubspec build number:

```sh
mise run version:bump <X.Y.Z>
```

Replace `<X.Y.Z>` with the new version, for example `2.3.6`.

## Verification

```sh
flutter analyze
```

The repository does not yet have a `test/` directory or a CI workflow. Record
analysis results and manual checks per platform in the PR, including failures
and checks that were not run.

## Structure

```text
lib/main.dart       application entry point
lib/screens/        screens
lib/widgets/        UI components
lib/providers/      state and Firebase access
lib/models/         models and generated JSON serialization
lib/l10n/           ARB translations
assets/             documents, images, and fonts
android/, ios/      native projects
web/                web bootstrap files
docker/             web build and Caddy configuration
```

## Contributing

The default branch is `develop`; target it in PRs. Use a conventional commit
title, such as `fix: correct medication search`. PR and issue templates live
in `.github/`. Include screenshots per platform for UI changes and describe
version, translation, generated code, and data contract changes. Keep this
README and the [Portuguese README](README.md) in sync.
