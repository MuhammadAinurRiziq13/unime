import 'dart:convert';
import 'package:http/http.dart' as http;
import 'anime_model.dart';

class AnimeService {
  final String _baseUrl = 'https://api.myanimelist.net/v2/anime/ranking?ranking_type=all&limit=20';
  final String _clientId = 'b21a2808537e92e3fa4fe94abb7dd680'; // Replace with your actual client ID

  Future<List<AnimeInfo>> fetchTopAnime() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'X-MAL-CLIENT-ID': _clientId,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final animes = AnimesResponse.fromJson(data);
        return animes.data;
      } else {
        print("Error: ${response.statusCode}");
        print("Body: ${response.body}");
        throw Exception('Failed to load anime: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception('Failed to load anime: $e');
    }
  }
}
