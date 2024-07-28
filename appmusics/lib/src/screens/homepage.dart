import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import '../models/track.dart';
import '../services/audio_service.dart';
import '../services/spotify_service.dart';
import 'music_player_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Track>> _recommendationsFuture;
  final AudioService _audioService = AudioService();
  Track? _currentTrack;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _recommendationsFuture = getRecommendations();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  void _navigateToPlayer(Track track) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicPlayerPage(track: track),
      ),
    );
  }

  void _likeTrack(String trackId) async {
    try {
      await likeTrack(trackId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Track liked!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Recommendations'),
      ),
      body: FutureBuilder<List<Track>>(
        future: _recommendationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recommendations found'));
          } else {
            final tracks = snapshot.data!;
            return ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return ListTile(
                  title: Text(track.name),
                  subtitle: Text(
                      track.artists.map((artist) => artist.name).join(', ')),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      _likeTrack(track.id); // Use actual track ID
                    },
                  ),
                  onTap: () {
                    _navigateToPlayer(track); // Navigate to MusicPlayerPage
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
