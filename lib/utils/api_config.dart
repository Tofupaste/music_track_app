class ApiConfig {
  // Spotify API configurations
  static const String spotifyBaseUrl = 'https://api.spotify.com/v1';
  static const String spotifyAccessToken = 'YOUR_SPOTIFY_ACCESS_TOKEN'; // Masukkan token akses Spotify di sini
  
  // YouTube API configurations
  static const String youtubeBaseUrl = 'https://www.googleapis.com/youtube/v3';
  static const String youtubeApiKey = 'YOUR_YOUTUBE_API_KEY'; // Masukkan API key YouTube di sini

  // Headers for Spotify requests
  static Map<String, String> getSpotifyHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // URLs
  static String getSearchArtistUrl(String query) {
    return '$spotifyBaseUrl/search?q=$query&type=artist';
  }

  static String getTopTracksUrl(String artistId) {
    return '$spotifyBaseUrl/artists/$artistId/top-tracks';
  }
}
