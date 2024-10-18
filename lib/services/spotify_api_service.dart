import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/artist.dart';
import '../models/song.dart';
import '../utils/api_config.dart';

class SpotifyApiService {
  // Mencari artis berdasarkan nama
  static Future<List<Artist>> searchArtists(String query) async {
    final url = ApiConfig.getSearchArtistUrl(query);

    // Gunakan access token dari Spotify (diperoleh melalui OAuth)
    final accessToken = 'YOUR_ACCESS_TOKEN'; // Ganti dengan token akses yang valid
    final response = await http.get(
      Uri.parse(url),
      headers: ApiConfig.getSpotifyHeaders(accessToken),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> artistsJson = data['artists']['items'];

      // Konversi JSON menjadi objek Artist
      return artistsJson.map((json) => Artist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search artists: ${response.statusCode}');
    }
  }

  // Mendapatkan top tracks dari artis berdasarkan ID
  static Future<List<Song>> getArtistTopTracks(String artistId, {String countryCode = 'US'}) async {
    final url = '${ApiConfig.getTopTracksUrl(artistId)}?market=$countryCode';

    // Gunakan access token dari Spotify
    final accessToken = 'YOUR_ACCESS_TOKEN'; // Ganti dengan token akses yang valid
    final response = await http.get(
      Uri.parse(url),
      headers: ApiConfig.getSpotifyHeaders(accessToken),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> tracksJson = data['tracks'];

      // Konversi JSON menjadi objek Song
      return tracksJson.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get top tracks: ${response.statusCode}');
    }
  }
}
