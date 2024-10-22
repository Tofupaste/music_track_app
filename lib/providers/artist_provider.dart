import 'package:flutter/material.dart';
import '../models/artist.dart';
import '../services/spotify_api_service.dart';
import '../services/youtube_api_service.dart';

class ArtistProvider with ChangeNotifier {
  List<Artist> _artists = [];
  Artist? _selectedArtist;
  bool _isLoading = false;
  String _errorMessage = '';

  List<Artist> get artists => _artists;
  Artist? get selectedArtist => _selectedArtist;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fungsi untuk mencari artis berdasarkan nama
  Future<void> searchArtists(String artistName) async {
    print("Searching artists for: $artistName"); // Debugging untuk memastikan fungsi dipanggil
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Cari artis dari Spotify
      List<Artist> spotifyArtists = await SpotifyApiService.searchArtists(artistName);
      print("Found ${spotifyArtists.length} artists from Spotify");

      // Cari video artis dari YouTube
      List<Map<String, dynamic>> youtubeVideos = await YouTubeApiService.searchVideos(artistName);

      // Konversi video YouTube menjadi artis (jika ada data yang relevan)
      List<Artist> youtubeArtists = youtubeVideos.map((video) {
        return Artist(
          id: video['videoId'],
          name: video['title'],
          imageUrl: video['thumbnailUrl'],
        );
      }).toList();
      print("Found ${youtubeArtists.length} artists from YouTube");

      // Menggabungkan hasil dari Spotify dan YouTube, menghindari duplikasi
      _artists = [...spotifyArtists];
      
      for (var youtubeArtist in youtubeArtists) {
        bool isDuplicate = spotifyArtists.any((spotifyArtist) => spotifyArtist.name == youtubeArtist.name);
        if (!isDuplicate) {
          _artists.add(youtubeArtist);
        }
      }

      print("Total artists after merging: ${_artists.length}");
    } catch (error) {
      _errorMessage = 'Failed to search artists: $error';
      print("Error: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk memilih artis dan mengambil detailnya
  void selectArtist(Artist artist) {
    _selectedArtist = artist;
    notifyListeners();
  }

  // Fungsi untuk membersihkan daftar artis
  void clearArtists() {
    _artists = [];
    _selectedArtist = null;
    _errorMessage = '';
    notifyListeners();
  }
}