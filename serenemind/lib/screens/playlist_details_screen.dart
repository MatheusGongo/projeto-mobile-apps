import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final Map<String, dynamic> playlist;

  PlaylistDetailScreen({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist['name']),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Playlist by ${playlist['owner']['display_name']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${playlist['description'] ?? 'No description available'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final url = playlist['external_urls']['spotify'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.deepPurple, // Define a cor de fundo do botão
              ),
              child: Text('Abrir no Spotify'),
            ),
            SizedBox(height: 20),
            Text(
              'Tracks:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: (playlist['tracks'] != null &&
                      playlist['tracks']['items'] != null)
                  ? ListView.builder(
                      itemCount: playlist['tracks']['items'].length,
                      itemBuilder: (context, index) {
                        final track =
                            playlist['tracks']['items'][index]['track'];
                        return ListTile(
                          title: Text(track['name']),
                          subtitle: Text(track['artists'][0]['name']),
                        );
                      },
                    )
                  : Center(
                      child: Text('No tracks available'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
