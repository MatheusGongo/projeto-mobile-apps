import 'package:flutter/material.dart';
import '../models/emotion.dart';
import 'emotion_result_screen.dart';

class EmotionSelectionScreen extends StatelessWidget {
  final List<Emotion> emotions = [
    Emotion(name: 'Feliz', description: 'Sentindo-se alegre e contente.'),
    Emotion(name: 'Triste', description: 'Sentindo-se para baixo e desanimado.'),
    Emotion(name: 'Ansioso', description: 'Sentindo-se nervoso e preocupado.'),
    Emotion(name: 'Calmo', description: 'Sentindo-se tranquilo e relaxado.'),
    Emotion(name: 'Indiferente', description: 'Sentindo-se neutro e apático.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Como você está se sentindo hoje?')),
      body: ListView.builder(
        itemCount: emotions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(emotions[index].name),
            subtitle: Text(emotions[index].description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmotionResultScreen(emotion: emotions[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
