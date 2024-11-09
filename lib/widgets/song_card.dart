import 'package:flutter/material.dart';
import '../models/song.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  final String selectedPlatform; // Tambahkan parameter platform

  const SongCard({
    Key? key,
    required this.song,
    required this.onTap,
    required this.selectedPlatform, // Tambahkan parameter platform
  }) : super(key: key);

  String formatListenerCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M'; // Format jutaan dengan 1 desimal
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K'; // Format ribuan dengan 1 desimal
    } else {
      return count.toString(); // Tampilkan angka secara langsung jika di bawah 1000
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: song.albumImageUrl != null
          ? Image.network(song.albumImageUrl!)
          : const Icon(Icons.music_note),
      title: Text(song.title),
      subtitle: Text(song.albumName),
      trailing: Text(
        selectedPlatform == 'Spotify'
            ? 'Spotify: ${formatListenerCount(song.spotifyListening)}'
            : 'YouTube: ${formatListenerCount(song.youtubeListening)}',
        style: TextStyle(
          color: selectedPlatform == 'Spotify' ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
