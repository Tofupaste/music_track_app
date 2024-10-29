import 'package:flutter/material.dart';
import '../models/artist.dart';
import '../services/spotify_api_service.dart';

class ArtistProvider with ChangeNotifier {
  List<Artist> _artists = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Artist> get artists => _artists;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fungsi untuk mencari artis berdasarkan nama
  Future<void> searchArtists(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Ambil daftar artis dari Spotify
      List<Artist> spotifyArtists = await SpotifyApiService.searchArtists(query);
      
      // Debugging output daftar artis
      debugPrint("Spotify Artists: $spotifyArtists");
      
      _artists = spotifyArtists;
    } catch (error) {
      _errorMessage = 'Failed to fetch artists: $error';
      debugPrint("Error fetching artists: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk membersihkan daftar artis
  void clearArtists() {
    _artists = [];
    _errorMessage = '';
    notifyListeners();
  }
}
