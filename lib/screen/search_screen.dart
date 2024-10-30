import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/artist_card.dart';
import '../providers/artist_provider.dart';
import 'artist_detail_screen.dart'; // Pastikan untuk mengimpor ArtistDetailScreen

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _searchArtists() {
    final provider = Provider.of<ArtistProvider>(context, listen: false);
    provider.searchArtists(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final artistProvider = Provider.of<ArtistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Artists'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter artist name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchArtists,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            artistProvider.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: artistProvider.artists.length,
                      itemBuilder: (context, index) {
                        final artist = artistProvider.artists[index];
                        return ArtistCard(
                          artist: artist,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtistDetailScreen(
                                  artistId: artist.id,
                                  artistName: artist.name,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}