import 'package:flutter/material.dart';
import '../models/song.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  final String selectedPlatform;

  const SongCard({
    Key? key,
    required this.song,
    required this.onTap,
    required this.selectedPlatform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menampilkan jumlah pendengar yang sesuai berdasarkan platform
    final listenerCount = selectedPlatform == 'Spotify'
        ? song.spotifyListening
        : song.youtubeListening;

    return Card(
      child: ListTile(
        title: Text(song.title),
        subtitle: Text('$selectedPlatform - $listenerCount views'), // Menampilkan view count yang sesuai
        onTap: onTap,
      ),
    );
  }
}
