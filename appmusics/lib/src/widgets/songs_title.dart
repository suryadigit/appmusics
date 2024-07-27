import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  final String title;
  final String artist;
  final String album;

  SongTile({required this.title, required this.artist, required this.album});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.music_note),
      title: Text(title),
      subtitle: Text('$artist - $album'),
      onTap: () {
        // Implement song detail view
      },
    );
  }
}
