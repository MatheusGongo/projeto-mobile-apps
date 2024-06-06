import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class ChatGPTService {
  final String apiUrl = 'https://api.openai.com/v1/completions';

  // Método para obter uma citação motivacional com base na emoção fornecida
  Future<String> getMotivationalQuote(String emotion) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${"Config.openaiApiKey"}', // Substitua YOUR_API_KEY_HERE pela sua chave de API do OpenAI
      },
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': 'Dê uma frase motivacional para alguém que está se sentindo $emotion.',
        'max_tokens': 60,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].trim();
    } else {
      throw Exception('Failed to fetch quote');
    }
  }

  // Método para obter exercícios mentais com base na emoção fornecida
  Future<List<String>> getMentalExercises(String emotion) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${"Config.openaiApiKey"}', // Substitua YOUR_API_KEY_HERE pela sua chave de API do OpenAI
      },
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': 'Liste alguns exercícios mentais para alguém que está se sentindo $emotion.',
        'max_tokens': 100,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].trim().split('\n');
    } else {
      throw Exception('Failed to fetch exercises');
    }
  }
}
