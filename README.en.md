# MPI Brasil
A mobile application to help people find information about medications and their effects on elderly patients.

## TODOs

- Environment setup (README).
- iOS build flow (README).

## Development

### Fetch the repository and dependencies

1. Clone the repository and create a new development branch:
    ```bash
    git checkout -b develop https://github.com/institutosocialtech/mpi-brasil.git frontend-flutter
    cd frontend-flutter
    ```

2. Clean and get the Flutter dependencies:
    ```bash
    flutter clean
    flutter pub get
    dart run intl_utils:generate
    ```

### Building for Debug

To build the debug version of the app, run:

- For Android:
    ```bash
    flutter build apk --debug
    ```

- For iOS:
    ```bash
    flutter build ios --debug
    ```

### Running the Application

To run the app in debug mode on your device, execute:

```bash
flutter run --debug
