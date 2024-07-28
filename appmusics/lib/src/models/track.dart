// lib/models/track.dart
class Track {
  final String id;
  final String name;
  final String? previewUrl;
  final List<Artist> artists;

  Track({
    required this.id,
    required this.name,
    this.previewUrl,
    required this.artists,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      name: json['name'],
      previewUrl: json['preview_url'],
      artists: (json['artists'] as List)
          .map((artistJson) => Artist.fromJson(artistJson))
          .toList(),
    );
  }
}

class Artist {
  final String name;

  Artist({required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(name: json['name']);
  }
}
