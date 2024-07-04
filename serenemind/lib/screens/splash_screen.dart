import 'package:flutter/material.dart';
import 'package:serenemind/screens/emotion_selection_screen.dart';
import 'emotion_result_screen.dart';
import '../models/emotion.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffAEAFF7),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adicionando a imagem no centro da tela
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background_serenemind.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmotionSelectionScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff371B34),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12.0), // Aqui você pode definir o valor que desejar
                  ),
                ),
                child: Text(
                  'Deixa-nos te ajudar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 40), // Ajuste de espaçamento inferior
            ],
          ),
        ),
      ),
    );
  }
}
