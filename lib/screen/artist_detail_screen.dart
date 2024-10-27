import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/song_card.dart';
import '../providers/song_provider.dart';

class ArtistDetailScreen extends StatelessWidget {
  final String artistId;
  final String artistName; // Menambahkan parameter untuk nama artis

  const ArtistDetailScreen({Key? key, required this.artistId, required this.artistName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context, listen: false);
    
    // Fetch songs ketika screen dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      songProvider.fetchSongs(artistId, artistName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('$artistName - Top Tracks'), // Tampilkan nama artis di judul
      ),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          return songProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: songProvider.songs.length,
                  itemBuilder: (context, index) {
                    final song = songProvider.songs[index];
                    return SongCard(
                      song: song,
                      onTap: () {
                        // Logic ketika song card ditekan (misalnya, putar lagu atau tampilkan detail lagu)
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
