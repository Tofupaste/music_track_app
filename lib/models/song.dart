class Song {
  final String id;
  final String title;
  final String albumName;
  final String? albumImageUrl; // Gambar album, bisa null
  int spotifyListening; // Jumlah pendengar Spotify
  int youtubeListening; // Jumlah pendengar YouTube

  Song({
    required this.id,
    required this.title,
    required this.albumName,
    this.albumImageUrl,
    this.spotifyListening = 0, // Default ke 0 jika tidak disediakan
    this.youtubeListening = 0, // Default ke 0 jika tidak disediakan
  });

  // Factory method untuk membuat instance Song dari data JSON yang diterima dari API
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['name'],
      albumName: json['album']['name'],
      albumImageUrl: json['album']['images']?.isNotEmpty == true
          ? json['album']['images'][0]['url']
          : null, // Mengambil URL gambar album jika ada
      spotifyListening: json['popularity'] ?? 0, // Jika ada informasi popularitas dari Spotify
      youtubeListening: json['external_ids']['youtube'] ?? 0, // Mengambil jumlah pendengar YouTube jika ada
    );
  }
}