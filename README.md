# Serenemind

Serenemind é um aplicativo móvel desenvolvido com Flutter que ajuda os usuários a gerenciar suas emoções diárias fornecendo frases motivacionais, playlists musicais do Spotify e exercícios mentais personalizados.

## Índice

- [Visão Geral](#visão-geral)
- [Funcionalidades](#funcionalidades)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Uso](#uso)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Visão Geral

O aplicativo Serenemind permite que os usuários selecionem como estão se sentindo e, com base na emoção selecionada, oferece conteúdos personalizados que incluem frases motivacionais, playlists musicais do Spotify e exercícios mentais. O objetivo é promover o bem-estar emocional e mental dos usuários.

## Funcionalidades

- **Autenticação com Spotify**: Permite aos usuários se autenticarem com suas contas do Spotify.
- **Seleção de Emoções**: Usuários podem selecionar suas emoções a partir de uma lista predefinida.
- **Frases Motivacionais**: Fornece frases motivacionais baseadas na emoção selecionada.
- **Playlists Musicais**: Exibe playlists musicais do Spotify relacionadas à emoção selecionada.
- **Exercícios Mentais**: Sugere exercícios mentais personalizados com base na emoção selecionada.

## Pré-requisitos

- Flutter SDK: [Flutter installation](https://flutter.dev/docs/get-started/install)
- Conta no Spotify Developer: [Spotify Developer](https://developer.spotify.com/dashboard/login)
- Conta no OpenAI: [OpenAI](https://beta.openai.com/signup/)

## Instalação

1. Clone o repositório:

   ```bash
   git clone https://github.com/MatheusGongo/projeto-mobile-apps.git
   cd projeto-mobile-apps

2. Instale as dependências:

 ```bash
   flutter pub get

## Configuração

1. Crie um arquivo config.dart em lib/ e adicione suas chaves de API do OpenAI e do Spotify:

```dart
class Config {
  static const String openaiApiKey = 'SUA_OPENAI_API_KEY';
  static const String spotifyClientId = 'SEU_SPOTIFY_CLIENT_ID';
  static const String spotifyClientSecret = 'SEU_SPOTIFY_CLIENT_SECRET';
}

2. Configure os redirecionamentos de URL no Spotify Developer Dashboard:

- Adicione serenemind://callback nas Redirect URIs.

3. Configure o AndroidManifest.xml para suportar o esquema de URL personalizado:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="serenemind"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="serenemind" android:host="callback" />
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
    <uses-permission android:name="android.permission.INTERNET"/>
</manifest>

## Uso

1. Execute o aplicativo:

```bash
flutter run

2. Selecione uma emoção na tela principal.

3. Explore as frases motivacionais, playlists musicais e exercícios mentais fornecidos com base na sua seleção.


