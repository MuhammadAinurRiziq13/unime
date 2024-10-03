import 'dart:convert';
import 'package:http/http.dart' as http;
import 'anime_model.dart';

class AnimeService {
  final String _baseUrl = 'https://api.myanimelist.net/v2';
  final String _clientId = 'b21a2808537e92e3fa4fe94abb7dd680';

  Future<List<AnimeInfo>> fetchTopAnime() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/anime/ranking?ranking_type=all&limit=20'),
        headers: {
          'X-MAL-CLIENT-ID': _clientId,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<AnimeInfo> animeList = (data['data'] as List)
            .map((item) => AnimeInfo.fromJson(item))
            .toList();

        // Fetch ratings for each anime
        for (var anime in animeList) {
          anime.mean = await fetchAnimeRating(anime.id);
        }

        return animeList;
      } else {
        print("Error: ${response.statusCode}");
        print("Body: ${response.body}");
        throw Exception('Failed to load anime list: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception('Failed to load anime list: $e');
    }
  }

  Future<double?> fetchAnimeRating(int animeId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/anime/$animeId?fields=mean'),
        headers: {
          'X-MAL-CLIENT-ID': _clientId,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['mean']?.toDouble();
      } else {
        print("Error fetching rating: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception fetching rating: $e");
      return null;
    }
  }
}
