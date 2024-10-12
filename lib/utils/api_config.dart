class ApiConfig {
  // Base URLs untuk API
  static const String spotifyBaseUrl = 'https://api.spotify.com/v1';
  static const String youtubeBaseUrl = 'https://www.googleapis.com/youtube/v3';

  // API Keys
  static const String spotifyApiKey = 'YOUR_SPOTIFY_API_KEY';
  static const String youtubeApiKey = 'YOUR_YOUTUBE_API_KEY';

  // Endpoint paths
  static const String searchArtistEndpoint = '/search';
  static const String topTracksEndpoint = '/artists/{id}/top-tracks';

  // Function untuk mendapatkan header authorization Spotify
  static Map<String, String> getSpotifyHeaders(String accessToken) {
    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
  }

  // URL template untuk mendapatkan top tracks dari artis
  static String getTopTracksUrl(String artistId) {
    return '$spotifyBaseUrl/artists/$artistId/top-tracks';
  }

  // URL template untuk search artis
  static String getSearchArtistUrl(String query) {
    return '$spotifyBaseUrl$searchArtistEndpoint?q=$query&type=artist';
  }
}
