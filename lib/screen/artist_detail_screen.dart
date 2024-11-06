import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/song_card.dart';
import '../providers/song_provider.dart';

class ArtistDetailScreen extends StatefulWidget {
  final String artistId;
  final String artistName;

  const ArtistDetailScreen({
    Key? key,
    required this.artistId,
    required this.artistName,
  }) : super(key: key);

  @override
  _ArtistDetailScreenState createState() => _ArtistDetailScreenState();
}

class _ArtistDetailScreenState extends State<ArtistDetailScreen> {
  bool _isInitialized = false; // Tambahan flag untuk memastikan fetchSongs hanya sekali

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      Provider.of<SongProvider>(context, listen: false)
          .fetchSongs(widget.artistId, widget.artistName);
      _isInitialized = true; // Set flag agar fetchSongs tidak dipanggil lagi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.artistName} - Top Tracks'),
      ),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          if (songProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (songProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(songProvider.errorMessage)); // Menampilkan error message jika ada
          } else {
            return ListView.builder(
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
            );
          }
        },
      ),
    );
  }
}
