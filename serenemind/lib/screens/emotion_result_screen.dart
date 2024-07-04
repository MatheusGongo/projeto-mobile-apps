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
        title: Text('Playlists para a emoção: ${widget.emotion.name}'),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: playlists.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(
                      Icons.music_note,
                      color: Colors.purple,
                    ),
                    title: Text(
                      playlist['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'by ${playlist['owner']['display_name']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.purple,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistDetailScreen(
                            playlistId: playlist['id'],
                            playlistName: playlist['name'],
                            ownerName: playlist['owner']['display_name'],
                            description: playlist['description'],
                            externalUrl: playlist['external_urls']['spotify'],
                          ),
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
