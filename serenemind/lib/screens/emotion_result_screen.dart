import 'package:flutter/material.dart';
import '../models/emotion.dart';
import '../services/spotify_service.dart';
import '../screens/playlist_details_screen.dart';

class EmotionResultScreen extends StatefulWidget {
  final Emotion emotion;

  EmotionResultScreen({required this.emotion});

  @override
  _EmotionResultScreenState createState() => _EmotionResultScreenState();
}

class _EmotionResultScreenState extends State<EmotionResultScreen> {
  late SpotifyService spotifyService;
  List<dynamic> playlists = [];

  @override
  void initState() {
    super.initState();
    spotifyService = SpotifyService(
      clientId: '4d9977a3d0ab42e893b93c8c77a76e8b',
      clientSecret: 'f8f98d96431a4cb48496a38cf26f2f3a',
    );
    fetchPlaylists();
  }

  Future<void> fetchPlaylists() async {
    try {
      final fetchedPlaylists = await spotifyService.getPlaylists(widget.emotion.name);
      setState(() {
        playlists = fetchedPlaylists;
      });
    } catch (e) {
      print('Error fetching playlists: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlists para ${widget.emotion.name}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: playlists.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(playlist['name']),
                    subtitle: Text('by ${playlist['owner']['display_name']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistDetailScreen(playlist: playlist),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
