import 'package:flutter/material.dart';
import '../models/artist.dart';
import '../services/spotify_api_services.dart';
import '../models/song.dart';

class ArtistDetailScreen extends StatefulWidget {
  final Artist artist;

  ArtistDetailScreen({required this.artist});

  @override
  _ArtistDetailScreenState createState() => _ArtistDetailScreenState();
}

class _ArtistDetailScreenState extends State<ArtistDetailScreen> {
  List<Song> _songs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchArtistSongs();
  }

  void _fetchArtistSongs() async {
    List<Song> songs = await SpotifyApiService.getArtistTopTracks(widget.artist.id);
    setState(() {
      _songs = songs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artist.name),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                final song = _songs[index];
                return ListTile(
                  leading: song.albumImageUrl != null
                      ? Image.network(song.albumImageUrl!)
                      : Icon(Icons.music_note),
                  title: Text(song.title),
                  subtitle: Text(song.albumName),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      // Arahkan pengguna ke Spotify atau YouTube
                      // Misalnya, menggunakan url_launcher package untuk membuka URL
                    },
                  ),
                );
              },
            ),
    );
  }
}
