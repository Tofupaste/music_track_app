import 'package:flutter/material.dart';
import '../models/song.dart';
import '../services/spotify_api_service.dart';
import '../services/youtube_api_service.dart';

class SongProvider with ChangeNotifier {
  List<Song> _songs = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Song> get songs => _songs;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchSongs(String artistId, String artistName) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Ambil top tracks dari Spotify
      List<Song> spotifySongs = await SpotifyApiService.getArtistTopTracks(artistId);

      // Ambil video dari YouTube berdasarkan nama artis
      List<Map<String, dynamic>> youtubeVideos = await YouTubeApiService.searchVideos(artistName);

      // Konversi video dari YouTube ke dalam model Song
      List<Song> youtubeSongs = youtubeVideos.map((video) {
        return Song(
          id: video['videoId'],
          title: video['title'],
          albumName: 'YouTube Video',
          albumImageUrl: video['thumbnailUrl'],
          youtubeListening: video['viewCount'] ?? 0, // Pastikan viewCount diambil dengan benar
          spotifyListening: 0,
        );
      }).toList();

      // Gabungkan data dari Spotify dan YouTube
      _songs = [...spotifySongs, ...youtubeSongs];
    } catch (error) {
      _errorMessage = 'Failed to fetch songs: $error';
      debugPrint("Error fetching songs: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSongs() {
    _songs = [];
    _errorMessage = '';
    notifyListeners();
  }
}