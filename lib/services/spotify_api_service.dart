import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/artist.dart';
import '../models/song.dart';
import '../utils/api_config.dart';
import '../services/spotify_auth_services.dart';

class SpotifyApiService {
  // Mencari artis berdasarkan nama
  static Future<List<Artist>> searchArtists(String query) async {
    final url = ApiConfig.getSearchArtistUrl(query);

    String accessToken = await SpotifyAuthService.getAccessToken();
    final response = await http.get(
      Uri.parse(url),
      headers: ApiConfig.getSpotifyHeaders(accessToken),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('Spotify response data: ${data.toString()}');
      final List<dynamic> artistsJson = data['artists']['items'];
      return artistsJson.map((json) => Artist.fromJson(json)).toList();
    } else {
      debugPrint('Error searching artists: ${response.body}');
      throw Exception('Failed to search artists: ${response.statusCode}');
    }
  }

// Mendapatkan top tracks dari artis berdasarkan ID
static Future<List<Song>> getArtistTopTracks(String artistId, {String countryCode = 'US'}) async {
  final url = '${ApiConfig.getTopTracksUrl(artistId)}?market=$countryCode';
  String accessToken = await SpotifyAuthService.getAccessToken();

  final response = await http.get(
    Uri.parse(url),
    headers: ApiConfig.getSpotifyHeaders(accessToken),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    // Pastikan struktur data sesuai
    if (data != null && data['tracks'] != null) {
      final List<dynamic> tracksJson = data['tracks'];

      // Debug data mentah API
      debugPrint('Spotify Top Tracks Response: ${data.toString()}');

      // Mapping data menjadi objek Song
      return tracksJson.map((json) => Song.fromSpotifyJson(json)).toList();
    } else {
      debugPrint('Unexpected data structure: ${response.body}');
      throw Exception('Invalid data structure in response.');
    }
  } else {
    debugPrint('Error fetching top tracks: ${response.body}');
    throw Exception('Failed to get top tracks: ${response.statusCode}');
  }
}

}