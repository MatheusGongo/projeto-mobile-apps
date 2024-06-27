import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/emotion.dart';
import 'emotion_result_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EmotionSelectionScreen extends StatelessWidget {
  final List<Emotion> emotions = [
    Emotion(name: 'Feliz'),
    Emotion(name: 'Calmo'),
    Emotion(name: 'Relaxado'),
    Emotion(name: 'Focado'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bem vindo!',
          style: GoogleFonts.alegreyaSans(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Como você está se sentindo hoje?',
              style: GoogleFonts.alegreyaSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: emotions.map((emotion) {
                return EmotionButton(emotion: emotion);
              }).toList(),
            ),
            SizedBox(height: 32),
            Text(
              'Atividades do dia',
              style: GoogleFonts.alegreyaSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ActivityCard(
              title: 'Yoga e Meditação',
              description: 'Aprenda a fazer Yoga e meditar',
              icon: Icons.spa,
              onPressed: () async {
                const url = 'https://www.youtube.com/playlist?list=PLsTqUcSUZLJEgRSCkp_0pdOiCCyHkXeHD'; // link da playlist do YouTube
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            SizedBox(height: 16),
            ActivityCard(
              title: 'Músicas',
              description: 'Selecionamos para ti as músicas que te deixaram tranquilo(a).',
              icon: Icons.music_note,
              onPressed: () async {
                const url = 'https://open.spotify.com/playlist/37i9dQZF1DX3rxVfibe1L0'; // link da playlist do Spotify
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmotionButton extends StatelessWidget {
  final Emotion emotion;

  const EmotionButton({
    required this.emotion,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmotionResultScreen(emotion: emotion),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: _getEmotionColor(emotion.name),
            child: Icon(_getEmotionIcon(emotion.name), color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            emotion.name,
            style: GoogleFonts.alegreyaSans(fontSize: 16),
          ),
        ],
      ),
    );
  }

  IconData _getEmotionIcon(String name) {
    switch (name) {
      case 'Feliz':
        return Icons.sentiment_satisfied;
      case 'Calmo':
        return Icons.self_improvement;
      case 'Relaxado':
        return Icons.spa;
      case 'Focado':
        return Icons.self_improvement;
      default:
        return Icons.sentiment_satisfied;
    }
  }

  Color _getEmotionColor(String name) {
    switch (name) {
      case 'Feliz':
        return Colors.pink;
      case 'Calmo':
        return Colors.blueAccent;
      case 'Relaxado':
        return Colors.orange;
      case 'Focado':
        return Colors.teal;
      default:
        return Colors.pink;
    }
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const ActivityCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(
          title,
          style: GoogleFonts.alegreyaSans(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description, style: GoogleFonts.alegreyaSans(fontSize: 14)),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: Text('Realizar', style: GoogleFonts.alegreyaSans(fontSize: 14)),
        ),
      ),
    );
  }
}
