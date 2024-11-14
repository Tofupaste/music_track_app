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
      child: ListTile(
        leading: song.albumImageUrl != null
            ? FadeInImage.assetNetwork(
                placeholder: 'lib/assets/images/loading.png',
                image: song.albumImageUrl!,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('lib/assets/images/music_cross.png', fit: BoxFit.cover);
                },
              )
            : Image.asset('lib/assets/images/music_cross.png', fit: BoxFit.cover),
        title: Text(song.title),
        subtitle: Text('$selectedPlatform - ${formatNumber(listenerCount)} views'),
        onTap: onTap,
      ),
    );
  }
}
