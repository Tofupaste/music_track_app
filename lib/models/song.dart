class Song {
  final String id;
  final String title;
  final String albumName;
  final String? albumImageUrl;
  final int spotifyListening;
  final int youtubeListening;

  Song({
    required this.id,
    required this.title,
    required this.albumName,
    this.albumImageUrl,
    this.spotifyListening = 0,
    this.youtubeListening = 0,
  });

  // Factory method untuk membuat instance Song dari data JSON yang diterima dari Spotify API
  factory Song.fromSpotifyJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['name'] as String,
      albumName: json['album']['name'] as String,
      albumImageUrl: json['album']['images']?.isNotEmpty == true
          ? json['album']['images'][0]['url'] as String
          : null, // Mengambil URL gambar album jika ada
      spotifyListening: json['popularity'] as int? ?? 0, // Mendapatkan popularitas Spotify jika ada
    );
  }

  // Factory method untuk membuat instance Song dari data JSON yang diterima dari YouTube API
  factory Song.fromYouTubeJson(Map<String, dynamic> json) {
    final thumbnails = json['snippet']['thumbnails'];
    final albumImageUrl = thumbnails?['high']?['url'] ?? // Prioritas ke kualitas 'high'
        thumbnails?['medium']?['url'] ?? // Fallback ke 'medium' jika 'high' tidak ada
        thumbnails?['default']?['url']; // Fallback terakhir ke 'default'

    // Debugging log (opsional)
    // print('Thumbnail data: $thumbnails');
    // print('Selected thumbnail URL: $albumImageUrl');

    return Song(
      id: json['id']?['videoId'] as String? ?? '', // Default ke string kosong jika ID hilang
      title: json['snippet']?['title'] as String? ?? 'Unknown Title',
      albumName: json['snippet']?['channelTitle'] as String? ?? 'Unknown Channel', // Nama channel sebagai albumName
      albumImageUrl: albumImageUrl, // Thumbnail gambar
      youtubeListening: int.tryParse(json['statistics']?['viewCount'] ?? '0') ?? 0, // Mendapatkan jumlah view YouTube
    );
  }
}
