import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/song.dart';
import '../utils/api_config.dart';

class YouTubeApiService {
  static Future<List<Song>> searchVideos(String artistName) async {
    final url = Uri.parse(ApiConfig.getYouTubeSearchUrl(artistName, maxResults: 20));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Song> songs = [];

      for (var item in data['items'] ?? []) {
        final videoId = item['id']?['videoId'];
        if (videoId == null) continue; // Skip jika videoId tidak ditemukan

        final videoDetailsUrl = Uri.parse(ApiConfig.getYouTubeVideoDetailsUrl(videoId));
        final videoResponse = await http.get(videoDetailsUrl);

        if (videoResponse.statusCode == 200) {
          final videoData = json.decode(videoResponse.body);
          final statistics = videoData['items']?[0]['statistics'];

          if (statistics != null) {
            // Gabungkan data item dengan statistik untuk konstruksi Song
            final fullData = {
              'id': item['id'],
              'snippet': item['snippet'],
              'statistics': statistics, // Tambahkan statistik views
            };

            try {
              songs.add(Song.fromYouTubeJson(fullData)); // Buat Song langsung dari JSON
            } catch (e) {
              debugPrint('Error creating Song: $e');
            }
          } else {
            debugPrint("No statistics available for videoId: $videoId");
          }
        } else {
          debugPrint("Failed to fetch video details for videoId: $videoId");
        }
      }

      return songs;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}