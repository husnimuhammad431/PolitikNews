import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:politic_news/src/lib/shared_preferences_service.dart';
import 'package:politic_news/src/models/news_model.dart';

class NewsController {
  final String baseUrl = 'http://45.149.187.204:3000/api';

  Future<NewsResponse> getAuthorNews() async {
    final token = SharedPreferencesService.getToken();
    if (token == null) throw Exception('Not authenticated');

    final url = Uri.parse('$baseUrl/author/news');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(responseData);
    } else {
      final error = responseData['body'] ?? responseData;
      throw Exception(
        error['message'] ??
            'Failed to load author news: ${response.statusCode}',
      );
    }
  }

  Future<NewsResponse> getPublishedNews({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? tags,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/news').replace(
        queryParameters: {
          'page': page.toString(),
          'limit': limit.toString(),
          if (category != null) 'category': category,
          if (search != null) 'search': search,
          if (tags != null) 'tags': tags,
        },
      );

      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(responseData);
      } else {
        final error = responseData['body'] ?? responseData;
        throw Exception(
          error['message'] ?? 'Failed to load news: ${response.statusCode}',
        );
      }
    } on FormatException catch (e) {
      throw Exception('Invalid response format: $e');
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }

  Future<SingleNewsResponse> getAuthorNewsById(String id) async {
    final token = SharedPreferencesService.getToken();
    if (token == null) throw Exception('Not authenticated');

    final url = Uri.parse('$baseUrl/author/news/$id');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      return SingleNewsResponse.fromJson(responseData);
    } else {
      final error = responseData['body'] ?? responseData;
      throw Exception(
        error['message'] ?? 'Failed to load news: ${response.statusCode}',
      );
    }
  }

  Future<SingleNewsResponse> getNewsBySlug(String slug) async {
    final url = Uri.parse('$baseUrl/news/$slug');

    final response = await http.get(url);
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      return SingleNewsResponse.fromJson(responseData);
    } else {
      final error = responseData['body'] ?? responseData;
      throw Exception(
        error['message'] ?? 'Failed to load news: ${response.statusCode}',
      );
    }
  }

  Future<SingleNewsResponse> createNews(CreateNewsRequest request) async {
    final token = SharedPreferencesService.getToken();
    if (token == null) throw Exception('Not authenticated');

    final url = Uri.parse('$baseUrl/author/news');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(request.toJson()),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      return SingleNewsResponse.fromJson(responseData);
    } else {
      final error = responseData['body'] ?? responseData;
      throw Exception(
        error['message'] ?? 'Failed to create news: ${response.statusCode}',
      );
    }
  }

  Future<SingleNewsResponse> updateNews(
    String id,
    UpdateNewsRequest request,
  ) async {
    final token = SharedPreferencesService.getToken();
    if (token == null) throw Exception('Not authenticated');

    final url = Uri.parse('$baseUrl/author/news/$id');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(request.toJson()),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      return SingleNewsResponse.fromJson(responseData);
    } else {
      final error = responseData['body'] ?? responseData;
      throw Exception(
        error['message'] ?? 'Failed to update news: ${response.statusCode}',
      );
    }
  }

  Future<void> deleteNews(String id) async {
    final token = SharedPreferencesService.getToken();
    if (token == null) throw Exception('Not authenticated');

    final url = Uri.parse('$baseUrl/author/news/$id');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      final responseData = json.decode(response.body);
      final error = responseData['body'] ?? responseData;
      throw Exception(
        error['message'] ?? 'Failed to delete news: ${response.statusCode}',
      );
    }
  }
}
