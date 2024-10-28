import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_config.dart';

class YouTubeApiService {
  static Future<List<Map<String, dynamic>>> searchVideos(String query) async {
    final url = '${ApiConfig.youtubeBaseUrl}/search?part=snippet&q=$query&type=video&key=${ApiConfig.youtubeApiKey}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> videosJson = data['items'];
        return videosJson.map((video) {
          return {
            'videoId': video['id']['videoId'],
            'title': video['snippet']['title'],
            'thumbnailUrl': video['snippet']['thumbnails']['high']['url'],
          };
        }).toList();
      } else {
        throw Exception('Failed to search videos: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}