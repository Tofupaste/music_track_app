class ApiConfig {
  // Base URL untuk Spotify dan YouTube API
  static const String spotifyBaseUrl = 'https://api.spotify.com/v1';
  static const String youtubeBaseUrl = 'https://www.googleapis.com/youtube/v3';

  // YouTube API Key (ganti dengan API key Anda)
  static const String youtubeApiKey = 'YOUR_API_KEY';

  // URL untuk pencarian video di YouTube dengan `maxResults` sebagai parameter opsional
  static String getYouTubeSearchUrl(String artistName, {int maxResults = 20}) {
    return '$youtubeBaseUrl/search'
           '?part=snippet'
           '&q=${Uri.encodeComponent(artistName)}'
           '&type=video'
           '&maxResults=$maxResults'
           '&key=$youtubeApiKey';
  }

  // URL untuk mengambil detail video di YouTube (mengambil statistik seperti view count)
  static String getYouTubeVideoDetailsUrl(String videoId) {
    return '$youtubeBaseUrl/videos'
           '?part=statistics'
           '&id=$videoId'
           '&key=$youtubeApiKey';
  }

  // Headers untuk permintaan Spotify (token harus didapatkan secara dinamis)
  static Map<String, String> getSpotifyHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // URL untuk mencari artis di Spotify
  static String getSearchArtistUrl(String query) {
    return '$spotifyBaseUrl/search?q=$query&type=artist';
  }

  // URL untuk mengambil top tracks dari artis di Spotify
  static String getTopTracksUrl(String artistId) {
    return '$spotifyBaseUrl/artists/$artistId/top-tracks?market=US'; // Market dapat disesuaikan
  }
}
