import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  // Đã gắn sẵn Key Groq của bạn
  static const String _apiKey = 'YOUR_API_KEY';

  // Đường link API chuẩn của hệ thống Groq
  static const String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';

  Future<String> sendMessage(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey', // Groq bắt buộc phải có chữ Bearer
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
        // Giải mã UTF-8 để không bị lỗi font tiếng Việt
        final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        // Bóc tách JSON theo chuẩn cấu trúc mới
        final String reply = data['choices'][0]['message']['content'];
        return reply.trim();

      } else {
        // Ép in ra lỗi chi tiết nếu Groq từ chối
        throw Exception('Groq chê: ${response.body}');
      }
    } catch (e) {
      throw Exception('Lỗi mạng/Code: $e');
    }
  }
}
