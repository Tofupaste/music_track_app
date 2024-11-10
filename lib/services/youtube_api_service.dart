import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/formatter.dart';
import '../utils/api_config.dart';

class YouTubeApiService {
  static Future<List<Map<String, dynamic>>> searchVideos(String artistName) async {
    final url = Uri.parse(ApiConfig.getYouTubeSearchUrl(artistName, maxResults: 20));
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> videos = [];

      for (var item in data['items'] ?? []) {
        final videoId = item['id']['videoId'];
        final videoDetailsUrl = Uri.parse(ApiConfig.getYouTubeVideoDetailsUrl(videoId));
        final videoResponse = await http.get(videoDetailsUrl);
        
        if (videoResponse.statusCode == 200) {
          final videoData = json.decode(videoResponse.body);
          final viewCount = int.tryParse(videoData['items']?[0]['statistics']?['viewCount'] ?? '0') ?? 0;
          final thumbnailUrl = item['snippet']['thumbnails']['high']['url'];
          
          videos.add({
            'videoId': videoId,
            'title': item['snippet']['title'],
            'thumbnailUrl': thumbnailUrl,
            'viewCount': viewCount, // Menyertakan viewCount
          });
        } else {
          debugPrint("Failed to fetch video details for videoId: $videoId");
        }
      }
      
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}