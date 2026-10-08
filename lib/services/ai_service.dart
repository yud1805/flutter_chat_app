import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {

  static const String _apiKey = 'YOUR_API_KEY';


  static const String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';

  Future<String> sendMessage(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          "model": "openai/gpt-oss-20b",
          "messages": [
            {
              "role": "user",
              "content": prompt
            }
          ]
        }),
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));


        final String reply = data['choices'][0]['message']['content'];
        return reply.trim();

      } else {

        throw Exception('Groq chê: ${response.body}');
      }
    } catch (e) {
      throw Exception('Lỗi mạng/Code: $e');
    }
  }
}
