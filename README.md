# MPI Brasil

[English](README.en.md)

Aplicativo Flutter para auxiliar profissionais de saúde na prescrição de
medicamentos para pacientes idosos. Reúne informações sobre MPI (medicamentos
potencialmente inapropriados) para apoiar a tomada de decisão clínica.

O app ainda acessa diretamente o Firebase Realtime Database
(`mpibrasil.firebaseio.com`) e o Firebase Authentication via Identity Toolkit.
A substituição pelo backend está em andamento; iniciar o backend local não
redireciona as chamadas do app. O plano e os contratos ficam em
`docs/contracts/` no workspace MPI Brasil, fora deste repositório.

## Requisitos

- Para desenvolvimento: mise e as ferramentas de `mise.toml`: Flutter 3.41,
  Java OpenJDK 17 e `android-sdk = "20"`.
- Para Android: SDK Android e dispositivo ou emulador configurado.
- Para iOS: macOS com Xcode e ambiente iOS configurado.
- Para compilar e servir somente a versão web: Docker com Docker Compose;
  não é necessário instalar Flutter no host.

## Executando

### 1. Baixar o repositório e preparar o ambiente

Com o mise instalado e ativado no shell:

```sh
mkdir -p ~/repos
git clone -b develop https://github.com/institutosocialtech/mpi-brasil.git ~/repos/mpibrasil
cd ~/repos/mpibrasil
mise trust
mise install
```

Para preparar os componentes Android declarados na tarefa do repositório:

```sh
mise run sdk:install
```

Essa tarefa chama `sdkmanager` para instalar build-tools 28.0.3, platform-tools,
tools e platforms;android-36. Verifique o ambiente da plataforma com
`flutter doctor` antes de compilar.

### 2. Dependências e geração de código

```sh
flutter pub get
dart run intl_utils:generate
```

As traduções ficam em `lib/l10n/*.arb`; o código de localização é gerado em
`lib/generated/` (ignorado pelo Git). Após alterar modelos JSON ou providers
anotados, regenere também os arquivos `.g.dart`:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Os arquivos `.g.dart` em `lib/models/` e `lib/providers/` são versionados.
Revise e inclua a geração correspondente no PR.

### 3. Executar em debug

```sh
flutter devices
flutter run --debug -d <device-id>
```

Substitua `<device-id>` pelo identificador listado por `flutter devices`.
Para web com WebAssembly:

```sh
flutter run -d chrome --wasm
```

### 4. Compilar em debug

Execute o comando da plataforma desejada, com seu ambiente configurado:

```sh
flutter build apk --debug
flutter build ios --debug
flutter build web --debug --wasm
```

A compilação iOS depende do ambiente macOS/Xcode e da configuração de assinatura.
TODO: documentar o provisionamento e a distribuição de versões Android/iOS.

### 5. Web com Docker

```sh
docker compose up --build
```

Acesse `http://localhost:8080`. O Compose usa `docker/Dockerfile`, baixa Flutter
3.41.9, gera as traduções, compila com `flutter build web --release --wasm` e
serve o resultado com Caddy. Para apenas compilar a imagem:

```sh
docker compose build
```

A imagem é `mpibrasil-flutter:<versão>`, com a tag definida em `compose.yaml`.
O Dockerfile não executa `build_runner`: mantenha os `.g.dart` versionados em dia.

O build WebAssembly requer os cabeçalhos `Cross-Origin-Opener-Policy: same-origin`
e `Cross-Origin-Embedder-Policy: require-corp`, configurados em `docker/Caddyfile`.
Preserve esses cabeçalhos nas respostas ao colocar outro proxy à frente do Caddy.

Os domínios planejados no rascunho de infraestrutura do workspace são
`app.mpibrasil.dev` e `app.staging.mpibrasil.dev`. Isso não confirma implantação
ativa. TODO: documentar o fluxo de implantação quando estiver definido.

## Versão

A versão fica em `VERSION`, `pubspec.yaml` e na tag da imagem em `compose.yaml`.
Para atualizar os três arquivos juntos, preservando o número de build do pubspec:

```sh
mise run version:bump <X.Y.Z>
```

Substitua `<X.Y.Z>` pela nova versão, por exemplo `2.3.6`.

## Verificação

```sh
flutter analyze
```

O repositório ainda não tem diretório `test/` nem workflow de CI. Registre no PR
os resultados da análise e das verificações manuais por plataforma, incluindo
falhas e verificações que não foram executadas.

## Estrutura

```text
lib/main.dart       entrada do aplicativo
lib/screens/        telas
lib/widgets/        componentes de interface
lib/providers/      estado e acesso ao Firebase
lib/models/         modelos e serialização JSON gerada
lib/l10n/           traduções em ARB
assets/             documentos, imagens e fontes
android/, ios/      projetos nativos
web/                arquivos de inicialização web
docker/             build web e configuração do Caddy
```

## Contribuindo

A branch padrão é `develop`; abra os PRs contra ela. Use um título em formato de
conventional commit, como `fix: correct medication search`. Os templates de PR e
de issue estão em `.github/`. Inclua capturas de tela por plataforma nas mudanças
de interface e descreva alterações de versão, traduções, código gerado e contratos
de dados. Mantenha este README e o [README em inglês](README.en.md) sincronizados.
