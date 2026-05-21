# MPI Brasil
A mobile application to help people find information about medications and their effects on elderly patients.

## Development

### 1. Development Environment

#### 1.1 Windows 11
    ```bash
    # start the ubuntu wsl installation, then follow the ubuntu-26.04-lts environment steps
    wsl --install Ubuntu-26.04
    ````

#### 1.2 Ubuntu 26.04 LTS
    ```bash
    # update the system
    sudo apt update && sudo apt upgrade -y

    # install the flutter linux dependencies
    sudo apt install -y curl fzf ripgrep yq
    sudo apt install -y build-essential clang cmake ninja-build pkg-config libgtk-3-dev

    # install mise
    curl -fsSL https://mise.run | sh
    echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
    ```

### 2. Fetch the repository and dependencies

#### 2.1. Clone the repository:
    ```bash
    mkdir ~/repos
    git checkout -b develop https://github.com/institutosocialtech/mpi-brasil.git ~/repos/mpibrasil
    cd ~/repos/mpibrasil
    ```

#### 2.2. Install the dependencies with mise:
    ```bash
    mise trust
    mise install
    mise run sdk:install
    ```

#### 2.3. Get the Flutter dependencies:
    ```bash
    flutter clean
    flutter pub get
    dart run intl_utils:generate
    ```

### 3. Building for Debug
To build the debug version of the app, run:

#### 3.1 Android:
    ```bash
    flutter build apk --debug
    ```

#### 3.2 iOS:
    ```bash
    flutter build ios --debug
    ```

#### 3.3 Web:
    ```bash
    flutter build web --debug --wasm
    ```

### 4. Running the Application
To run the app in debug mode on your device, execute:

```bash
flutter run --debug
```