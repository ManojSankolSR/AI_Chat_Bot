import 'dart:convert';

import 'package:http/http.dart' as http;

const String apikey = "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";

class chatgptapi {
  Future<String> chatgpt(String prompt) async {
    try {
      final resposne = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $apikey"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "system", "content": "$prompt"},
            ]
          }));

      final l = jsonDecode(resposne.body)["choices"][0]["message"]["content"];

      return l;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallai(String prompt) async {
    try {
      print(prompt);
      final response = await http.post(
          Uri.parse("https://api.openai.com/v1/images/generations"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $apikey",
          },
          body: jsonEncode({"prompt": prompt, "n": 1, "size": "512x512"}));
      final s = await jsonDecode(response.body)["data"][0]["url"];
      print(s);
      return s;
    } catch (e) {
      return e.toString();
    }
  }
}
