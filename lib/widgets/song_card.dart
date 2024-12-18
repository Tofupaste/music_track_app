import 'package:flutter/material.dart';
import '../models/song.dart';
import '../utils/formatter.dart';

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
    final listenerCount = selectedPlatform == 'Spotify'
        ? song.spotifyListening
        : song.youtubeListening;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: (song.albumImageUrl != null && song.albumImageUrl!.isNotEmpty)
              ? FadeInImage.assetNetwork(
                  placeholder: 'lib/assets/images/loading.png',
                  image: song.albumImageUrl!,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/assets/images/music_cross.png',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    );
                  },
                )
              : Image.asset(
                  'lib/assets/images/music_cross.png',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
        ),
        title: Text(
          song.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          selectedPlatform == 'Spotify'
              ? 'Popularity: ${formatNumber(listenerCount)}'
              : 'Views: ${formatNumber(listenerCount)}',
          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
        onTap: onTap,
      ),
    );
  }
}