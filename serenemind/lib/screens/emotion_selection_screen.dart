import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/emotion.dart';
import 'emotion_result_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class EmotionSelectionScreen extends StatelessWidget {

   final Color backgroundColor;

  EmotionSelectionScreen({this.backgroundColor = Colors.white});
  
  final List<Emotion> emotions = [
    Emotion(name: 'Feliz'),
    Emotion(name: 'Calmo'),
    Emotion(name: 'Relaxado'),
    Emotion(name: 'Focado'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 72),
            Text(
              'Atividades do dia',
              style: GoogleFonts.alegreyaSans(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ActivityCard(
              title: 'Meditação',
              description: 'Veja como você pode está meditando de acordo com o seu estado',
              color: Color(0xFFF09E54),
              icon: Icons.spa,
              buttonText: 'Realizar meditação',
              onPressed: () async {
                const url = 'https://www.youtube.com/playlist?list=PLsTqUcSUZLJEgRSCkp_0pdOiCCyHkXeHD';
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
              color: Color(0xFF58C474),
              icon: Icons.music_note,
              buttonText: 'Ouvir no Spotify',
              onPressed: () async {
                const url = 'https://open.spotify.com/playlist/37i9dQZF1DX3rxVfibe1L0';
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
        return Color(0xffEF5DA8);
      case 'Calmo':
        return Color(0xffAEAFF7);
      case 'Relaxado':
        return Color(0xffF09E54);
      case 'Focado':
        return Color(0xffA0E3E2);
      default:
        return Colors.pink;
    }
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final String buttonText;
  final VoidCallback onPressed;

  const ActivityCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.alegreyaSans(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.alegreyaSans(fontSize: 14, color: Colors.white),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff371B34),// Change `primary` to `backgroundColor`
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              buttonText,
              style: GoogleFonts.alegreyaSans(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}