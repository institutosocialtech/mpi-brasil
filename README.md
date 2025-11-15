# MPI Brasil
Aplicativo móvel para ajudar pessoas a encontrar informações sobre medicamentos e seus efeitos em pacientes idosos.

## TODOs

- Configuração do ambiente (README).
- Fluxo de build para iOS (README).

## Desenvolvimento

### Baixar o repositório e as dependências

1. Clone o repositório e crie uma nova branch para desenvolvimento:
    ```bash
    git checkout -b develop https://github.com/institutosocialtech/mpi-brasil.git frontend-flutter
    cd frontend-flutter
    ```

2. Obtenha as dependências do Flutter:
    ```bash
    flutter clean
    flutter pub get
    dart run intl_utils:generate
    ```

### Compilando para Debug

Para criar a versão de debug do aplicativo, execute:

- Para Android:
    ```bash
    flutter build apk --debug
    ```

- Para iOS:
    ```bash
    flutter build ios --debug
    ```

### Executar o aplicativo

Para executar o aplicativo em modo debug no seu dispositivo, execute:

```bash
flutter run --debug
