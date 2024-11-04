import 'package:flutter/material.dart';
import '../models/song.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;

  const SongCard({Key? key, required this.song, required this.onTap}) : super(key: key);

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
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Spotify: ${formatListenerCount(song.spotifyListening)}',
            style: TextStyle(color: Colors.green),
          ),
          const SizedBox(height: 4),
          Text(
            'YouTube: ${formatListenerCount(song.youtubeListening)}',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
