import 'package:flutter/material.dart';
import '../services/spotify_api_services.dart';
import '../models/artist.dart';
import 'artist_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Artist> _searchResults = [];
  bool _isLoading = false;

  void _searchArtist() async {
    if (_searchController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    List<Artist> results = await SpotifyApiService.searchArtist(_searchController.text);

    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Artist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter artist name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchArtist,
                ),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final artist = _searchResults[index];
                        return ListTile(
                          leading: artist.imageUrl != null
                              ? Image.network(artist.imageUrl!)
                              : Icon(Icons.person),
                          title: Text(artist.name),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtistDetailScreen(artist: artist),
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
