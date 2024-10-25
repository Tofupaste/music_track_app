class ApiConfig {
  // Spotify API configurations
  static const String spotifyBaseUrl = 'https://api.spotify.com/v1';
  
  // YouTube API configurations
  static const String youtubeBaseUrl = 'https://www.googleapis.com/youtube/v3';
  static const String youtubeApiKey = 'Enter ur youtube API here'; // Masukkan API key YouTube di sini

  // Headers for Spotify requests (token didapatkan secara dinamis)
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
