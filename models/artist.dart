class Artist {
  final String id;
  final String name;
  final String? imageUrl;

  Artist({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  // Factory method untuk membuat instance Artist dari data JSON yang diterima dari API
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['url']
          : null,
    );
  }
}
