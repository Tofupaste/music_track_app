import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/song_card.dart';
import '../providers/song_provider.dart';

class ArtistDetailScreen extends StatefulWidget {
  final String artistId;
  final String artistName;

  const ArtistDetailScreen({Key? key, required this.artistId, required this.artistName}) : super(key: key);

  @override
  State<ArtistDetailScreen> createState() => _ArtistDetailScreenState();
}

class _ArtistDetailScreenState extends State<ArtistDetailScreen> {
  String? _selectedPlatform;
  String _displayMode = 'Popular'; // Default mode is "Popular"

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPlatformSelectionDialog(context, (platform) {
        setState(() {
          _selectedPlatform = platform;
        });
        final songProvider = Provider.of<SongProvider>(context, listen: false);
        songProvider.clearSongs();
        songProvider.fetchSongs(widget.artistId, widget.artistName, platform);
      });
    });
  }

  void _showPlatformSelectionDialog(BuildContext context, Function(String) onPlatformSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Platform"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  onPlatformSelected("YouTube");
                  Navigator.of(context).pop();
                },
                child: const Text("YouTube"),
              ),
              ElevatedButton(
                onPressed: () {
                  onPlatformSelected("Spotify");
                  Navigator.of(context).pop();
                },
                child: const Text("Spotify"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleDisplayMode() {
    // Toggle antara Popular dan Most
    setState(() {
      _displayMode = _displayMode == 'Popular' ? 'Most' : 'Popular';
      final songProvider = Provider.of<SongProvider>(context, listen: false);
      songProvider.clearSongs();

      // Fetch data berdasarkan mode dan platform
      if (_displayMode == 'Popular') {
        songProvider.fetchSongs(widget.artistId, widget.artistName, _selectedPlatform!);
      } else {
        songProvider.setDummyMostSongs(); // Placeholder untuk Most
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.artistName} - Top Tracks (${_selectedPlatform ?? ""})'),
        actions: [
          // Tombol toggle akan terlihat untuk semua platform
          if (_selectedPlatform != null)
            TextButton(
              onPressed: _toggleDisplayMode,
              child: Text(
                _displayMode,
                style: const TextStyle(color: Color.fromARGB(255, 5, 230, 247)),
              ),
            ),
        ],
      ),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          if (_selectedPlatform == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return songProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : songProvider.errorMessage.isNotEmpty
                  ? Center(child: Text(songProvider.errorMessage))
                  : ListView.builder(
                      itemCount: songProvider.songs.length,
                      itemBuilder: (context, index) {
                        final song = songProvider.songs[index];
                        return SongCard(
                          song: song,
                          onTap: () {
                            // Logic untuk ketika song card ditekan
                          },
                          selectedPlatform: _selectedPlatform!,
                        );
                      },
                    );
        },
      ),
    );
  }
}