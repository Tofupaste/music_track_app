import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/song_provider.dart';
import '../widgets/song_card.dart';

class ArtistDetailScreen extends StatelessWidget {
  final String artistId;

  const ArtistDetailScreen({Key? key, required this.artistId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    
    // Fetch top tracks ketika screen dibuka
    songProvider.fetchTopTracks(artistId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Tracks'),
      ),
      body: songProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: songProvider.songs.length,
              itemBuilder: (context, index) {
                final song = songProvider.songs[index];
                return SongCard(
                  song: song,
                  onTap: () {
                    // Logic ketika song card ditekan
                  },
                );
              },
            ),
    );
  }
}
