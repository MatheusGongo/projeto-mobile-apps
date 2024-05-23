import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/emotion_selection_screen.dart';

void main() {
  runApp(SerenemindApp());
}

class SerenemindApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Registrar o manipulador de URL após o runApp()
    SystemChannels.platform.setMethodCallHandler((call) async {
      try {
        if (call.method == 'url' && call.arguments != null) {
          final String url = call.arguments.toString();
          if (url.startsWith('serenemind://')) {
            // Manipular a URL aqui, se necessário
          }
        }
      } catch (e) {
        print('Erro ao processar o método de chamada da plataforma: $e');
      }
    });

    return MaterialApp(
      home: EmotionSelectionScreen(),
    );
  }
}
