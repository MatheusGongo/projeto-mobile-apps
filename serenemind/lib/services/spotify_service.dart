import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class SpotifyService {
  String? accessToken;

  Future<void> authenticate() async {
    final authUrl = Uri.https('accounts.spotify.com', '/authorize', {
      'response_type': 'code',
      'client_id': "Config.spotifyClientId",
      'scope': 'playlist-read-private',
      'redirect_uri': 'serenemind://callback',
    }).toString();

    final result = await FlutterWebAuth.authenticate(
      url: authUrl,
      callbackUrlScheme: "serenemind"
    );

    final code = Uri.parse(result).queryParameters['code'];
    if (code == null) {
      throw Exception('Failed to get authorization code');
    }

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': 'serenemind://callback',
        'client_id': "Config.spotifyClientId",
        'client_secret': "Config.spotifyClientSecret",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      accessToken = data['access_token'];
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<List<String>> getPlaylists(String emotion) async {
    if (accessToken == null) {
      await authenticate();
    }

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$emotion&type=playlist'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> playlists = [];
      for (var item in data['playlists']['items']) {
        playlists.add(item['name']);
      }
      return playlists;
    } else {
      throw Exception('Failed to fetch playlists');
    }
  }
}
