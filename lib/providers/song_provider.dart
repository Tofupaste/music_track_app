import 'package:flutter/material.dart';
import '../models/song.dart';

class SongProvider with ChangeNotifier {
  List<Song> _songs = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Song> get songs => _songs;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void clearSongs() {
    _songs = [];
    notifyListeners();
  }

  Future<void> fetchSongs(String artistId, String artistName, String platform) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Logika fetch songs (Spotify / YouTube)
      // ...
      // Dummy data
      _songs = List.generate(
        10,
        (index) => Song(
          id: 'id_$index',
          title: 'Song $index',
          albumName: 'Album $index',
          albumImageUrl: 'https://via.placeholder.com/150',
        ),
      );
    } catch (e) {
      _errorMessage = 'Failed to load songs.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

void setDummyMostSongs() {
  _songs = List.generate(
    10,
    (index) => Song(
      id: 'most_id_$index',
      title: 'Most Played Song $index',
      albumName: 'Most Album $index',
      albumImageUrl: 'https://via.placeholder.com/150',
    ),
  );
  notifyListeners();
}
}