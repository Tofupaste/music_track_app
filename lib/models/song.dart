import 'package:flutter/material.dart';

class Song {
  final String id;
  final String title;
  final String albumName;
  final String? albumImageUrl;
  final int spotifyListening; // Listener dari Spotify
  final int youtubeListening; // Listener dari YouTube

  Song({
    required this.id,
    required this.title,
    required this.albumName,
    this.albumImageUrl,
    this.spotifyListening = 0,
    this.youtubeListening = 0,
  });

  // Factory method untuk membuat instance Song dari data JSON yang diterima dari Spotify API
  factory Song.fromSpotifyJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['name'] as String,
      albumName: json['album']['name'] as String,
      albumImageUrl: json['album']['images']?.isNotEmpty == true
          ? json['album']['images'][0]['url'] as String
          : null, // Mengambil URL gambar album jika ada
      spotifyListening: json['popularity'] as int? ?? 0, // Mendapatkan popularitas Spotify jika ada
    );
  }

  factory Song.fromYouTubeJson(Map<String, dynamic> json) {
    final thumbnails = json['snippet']['thumbnails'];
    final albumImageUrl = thumbnails?['high']?['url'] ??
        thumbnails?['medium']?['url'] ??
        thumbnails?['default']?['url'];

    if (albumImageUrl == null) {
      debugPrint('Thumbnail not found for video ID: ${json['id']?['videoId']}');
    }

    return Song(
      id: json['id']?['videoId'] as String? ?? '',
      title: json['snippet']?['title'] as String? ?? 'Unknown Title',
      albumName: json['snippet']?['channelTitle'] as String? ?? 'Unknown Channel',
      albumImageUrl: albumImageUrl,
      youtubeListening: int.tryParse(json['statistics']?['viewCount'] ?? '0') ?? 0,
    );
  }
}