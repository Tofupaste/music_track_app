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


}
