import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../services/chatgpt_service.dart';
import '../services/spotify_service.dart';
import '../widgets/loading_widget.dart';

class EmotionResultScreen extends StatefulWidget {
  final Emotion emotion;

  EmotionResultScreen({required this.emotion});

  @override
  _EmotionResultScreenState createState() => _EmotionResultScreenState();
}

class _EmotionResultScreenState extends State<EmotionResultScreen> {
  late Future<String> _quote;
  late Future<List<String>> _playlists;
  late Future<List<String>> _exercises;

  @override
  void initState() {
    super.initState();
    final chatGPTService = ChatGPTService();
    final spotifyService = SpotifyService();
    _quote = chatGPTService.getMotivationalQuote(widget.emotion.name);
    _playlists = spotifyService.getPlaylists(widget.emotion.name);
    _exercises = chatGPTService.getMentalExercises(widget.emotion.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultado para ${widget.emotion.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frase Motivacional:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<String>(
              future: _quote,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget();
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar frase');
                } else {
                  return Text(snapshot.data ?? '');
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Playlists do Spotify:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: _playlists,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar playlists');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Exercícios Mentais:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: _exercises,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar exercícios');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
