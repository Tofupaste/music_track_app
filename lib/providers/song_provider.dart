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

  // Fungsi untuk mengambil lagu dari Spotify dan YouTube berdasarkan ID artis
  Future<void> fetchSongs(String artistId, String artistName) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Ambil top tracks dari Spotify
      List<Song> spotifySongs = await SpotifyApiService.getArtistTopTracks(artistId);
      
      // Ambil video dari YouTube berdasarkan nama artis
      List<Map<String, dynamic>> youtubeVideos = await YouTubeApiService.searchVideos(artistName);

      // Konversi video YouTube menjadi Song (jika ada data yang relevan)
      List<Song> youtubeSongs = youtubeVideos.map((video) {
        return Song(
          id: video['videoId'],
          title: video['title'],
          albumName: 'YouTube Video', // Nama album bisa diisi default seperti ini
          albumImageUrl: video['thumbnailUrl'], // Sesuaikan dengan model Anda
          youtubeListening: video['viewCount'] ?? 0, // Default ke 0 jika tidak ada viewCount
          spotifyListening: 0, // Set default 0 karena ini data dari YouTube
        );
      }).toList();

      // Gabungkan kedua hasil dan update state
      _songs = [...spotifySongs, ...youtubeSongs];
    } catch (error) {
      _errorMessage = 'Failed to fetch songs: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk membersihkan daftar lagu
  void clearSongs() {
    _songs = [];
    _errorMessage = '';
    notifyListeners();
  }
}
