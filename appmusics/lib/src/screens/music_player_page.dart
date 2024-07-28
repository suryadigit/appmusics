// lib/music_player_page.dart
import 'package:appmusics/src/models/track.dart';
import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class MusicPlayerPage extends StatefulWidget {
  final Track track;

  const MusicPlayerPage({Key? key, required this.track}) : super(key: key);

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final AudioService _audioService = AudioService();
  bool _isPlaying = false;
  double _volume = 0.5; // Default volume level
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _playTrack();
    _audioService.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
    _audioService.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  Future<void> _playTrack() async {
    try {
      await _audioService.play(widget.track.previewUrl ?? '');
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      // Handle error
      print("Error playing track: $e");
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioService.pause();
    } else {
      _playTrack();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _changeVolume(double value) {
    _audioService.setVolume(value);
    setState(() {
      _volume = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = _totalDuration.inMilliseconds > 0
        ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.track.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Implement like functionality
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 120.0,
              backgroundImage:
                  AssetImage('assets/images.jpg'),
            ),
            const SizedBox(height: 20.0),
            Text(
              widget.track.name,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.track.artists.map((artist) => artist.name).join(', '),
              style: const TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            const SizedBox(height: 20.0),
            LinearProgressIndicator(
              value: progress,
              minHeight: 5.0,
              color: Colors.deepPurple,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 20.0),
            IconButton(
              icon:
                  Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 50.0),
              onPressed: _togglePlayPause,
            ),
            const SizedBox(height: 20.0),
            Text(
              '${_currentPosition.toString().split('.').first} / ${_totalDuration.toString().split('.').first}',
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            Slider(
              value: _volume,
              onChanged: _changeVolume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: 'Volume: ${(_volume * 100).toStringAsFixed(0)}%',
            ),
          ],
        ),
      ),
    );
  }
}
