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
    this.spotifyListening = 0,  // Default ke 0 jika tidak disediakan
    this.youtubeListening = 0,  // Default ke 0 jika tidak disediakan
  });


  // Factory method untuk membuat instance Song dari data JSON yang diterima dari API
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['name'],
      albumName: json['album']['name'],
      albumImageUrl: json['album']['images'] != null && json['album']['images'].isNotEmpty
          ? json['album']['images'][0]['url']
          : null,
    );
  }
}