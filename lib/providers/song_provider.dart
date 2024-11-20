import 'package:flutter/material.dart';
import '../models/song.dart';
import '../services/spotify_api_service.dart';
import '../services/youtube_api_service.dart';

class SongProvider with ChangeNotifier {
  List<Song> _songs = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedPlatform = ''; // Menyimpan platform yang dipilih

  List<Song> get songs => _songs;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedPlatform => _selectedPlatform;

  // Fungsi untuk mengatur platform yang dipilih
  void setPlatform(String platform) {
    _selectedPlatform = platform;
    notifyListeners();
  }

  Future<void> fetchSongs(String artistId, String artistName, String platform) async {
    _selectedPlatform = platform; // Simpan platform yang dipilih
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      if (platform == "Spotify") {
        // Ambil data dari Spotify
        _songs = await SpotifyApiService.getArtistTopTracks(artistId);
      } else if (platform == "YouTube") {
        // Ambil data dari YouTube
        _songs = await YouTubeApiService.searchVideos(artistName);

        // Sortir berdasarkan jumlah view YouTube (descending)
        _songs.sort((a, b) => b.youtubeListening.compareTo(a.youtubeListening));
      }
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