import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String playlistId;
  final String playlistName;
  final String ownerName;
  final String description;
  final String externalUrl;

  PlaylistDetailScreen({
    required this.playlistId,
    required this.playlistName,
    required this.ownerName,
    required this.description,
    required this.externalUrl,
  });

  @override
  _PlaylistDetailScreenState createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  List<dynamic> tracks = [];
  bool isLoading = true;

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentTrackUrl;

  @override
  void initState() {
    super.initState();
    fetchPlaylistTracks();
  }

  Future<void> fetchPlaylistTracks() async {
    try {
      final token = await fetchSpotifyAccessToken();
      final String url =
          'https://api.spotify.com/v1/playlists/${widget.playlistId}/tracks';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          tracks = json.decode(response.body)['items'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load playlist tracks');
      }
    } catch (e) {
      print('Error fetching playlist tracks: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String> fetchSpotifyAccessToken() async {
    final String clientId = '4d9977a3d0ab42e893b93c8c77a76e8b';
    final String clientSecret = 'f8f98d96431a4cb48496a38cf26f2f3a';
    final String url = 'https://accounts.spotify.com/api/token';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['access_token'];
    } else {
      throw Exception('Failed to obtain access token');
    }
  }

  Future<void> playMusic(String? url) async {
    if (url == null) {
      return;
    }

    if (url != currentTrackUrl) {
      await audioPlayer.setUrl(url);
      await audioPlayer.play();
      setState(() {
        isPlaying = true;
        currentTrackUrl = url;
      });
    } else {
      if (isPlaying) {
        await audioPlayer.pause();
        setState(() {
          isPlaying = false;
        });
      } else {
        await audioPlayer.play();
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.playlistName ?? '',
          style: TextStyle(
            color: Colors.white, // Define a cor do texto para branco
            fontSize: 20, // Pode ajustar o tamanho da fonte conforme necessário
            fontWeight: FontWeight.bold, // Pode definir o peso da fonte
          ),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Playlist by ${widget.ownerName}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Descrição: ${widget.description.isNotEmpty ? widget.description : 'No description available'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final url = widget.externalUrl;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                icon: Icon(Icons.open_in_new),
                label: Text('Abrir no Spotify'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tracks:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : tracks.isNotEmpty
                      ? ListView.builder(
                          itemCount: tracks.length,
                          itemBuilder: (context, index) {
                            final track = tracks[index]['track'];
                            final trackUrl = track['preview_url'];

                            return GestureDetector(
                              onTap: () {
                                playMusic(trackUrl);
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  leading: Icon(Icons.music_note,
                                      color: Colors.deepPurple),
                                  title: Text(
                                    track['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(track['artists'][0]['name']),
                                  trailing: IconButton(
                                    icon: Icon(
                                      isPlaying && currentTrackUrl == trackUrl
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      playMusic(trackUrl);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No tracks available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
