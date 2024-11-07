class ApiConfig {
  // Spotify API configurations
  static const String spotifyBaseUrl = 'https://api.spotify.com/v1';

  // YouTube API configurations
  static const String youtubeBaseUrl = 'https://www.googleapis.com/youtube/v3';
  static const String youtubeApiKey = 'Your API Youtube'; // Ganti dengan API key YouTube Anda
  
  // Headers for Spotify requests (token didapatkan secara dinamis)
  static Map<String, String> getSpotifyHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Spotify API URLs
  static String getSearchArtistUrl(String query) {
    return '$spotifyBaseUrl/search?q=$query&type=artist';
  }

  static String getTopTracksUrl(String artistId) {
    return '$spotifyBaseUrl/artists/$artistId/top-tracks';
  }

  // YouTube API URLs
  static String getYouTubeSearchUrl(String query) {
    return '$youtubeBaseUrl/search?part=snippet&q=$query&type=video&key=$youtubeApiKey';
  }

  static String getYouTubeVideoDetailsUrl(String videoId) {
    return '$youtubeBaseUrl/videos?part=statistics&id=$videoId&key=$youtubeApiKey';
  }
}
