# MPI Brasil
Aplicativo móvel para ajudar pessoas a encontrar informações sobre medicamentos e seus efeitos em pacientes idosos.

## Desenvolvimento

### 1. Ambiente de Desenvolvimento

#### 1.1 Windows 11
```bash
# inicie a instalaçao do ubuntu wsl, depois siga os passos do ambiente ubuntu-26.04-lts
wsl --install Ubuntu-26.04
````

#### 1.2 Ubuntu 26.04 LTS
```bash
# atualize o sistema
sudo apt update && sudo apt upgrade -y

# instale as dependencias do flutter linux
sudo apt install -y curl fzf ripgrep yq
sudo apt install -y build-essential clang cmake ninja-build pkg-config libgtk-3-dev

# instale o mise
curl -fsSL https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
```

### 2. Baixar o repositório e as dependências

#### 2.1. Clone o repositório:
```bash
mkdir ~/repos
git checkout -b develop https://github.com/institutosocialtech/mpi-brasil.git ~/repos/mpibrasil
cd ~/repos/mpibrasil
```

#### 2.2. Instale as dependencias com o mise:
```bash
mise trust
mise install
mise run sdk:install
```

#### 2.3. Obtenha as dependências do Flutter:
```bash
flutter clean
flutter pub get
dart run intl_utils:generate
```

### 3. Compilando para Debug
Para criar a versão de debug do aplicativo, execute:

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

### 4. Executar o aplicativo
Para executar o aplicativo em modo debug no seu dispositivo, execute:

```bash
flutter run --debug
```