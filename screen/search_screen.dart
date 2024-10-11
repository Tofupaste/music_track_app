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


}
