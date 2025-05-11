import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
