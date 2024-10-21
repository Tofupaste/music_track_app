import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/song_card.dart';
import '../providers/song_provider.dart'; // Pastikan untuk mengimpor SongProvider

class ArtistDetailScreen extends StatelessWidget {
  final String artistId;
  final String artistName; // Menambahkan parameter untuk nama artis

  const ArtistDetailScreen({Key? key, required this.artistId, required this.artistName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);
    
    // Fetch songs ketika screen dibuka
    songProvider.fetchSongs(artistId, artistName); // Ubah ke fetchSongs dengan dua argumen

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
