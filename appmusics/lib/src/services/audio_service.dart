// lib/services/audio_service.dart
import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String url) async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      _player.play();
    } catch (e) {
      print("Error playing track: $e");
    }
  }

  void pause() {
    _player.pause();
  }

  void stop() {
    _player.stop();
  }

  void setVolume(double volume) {
    _player.setVolume(volume);
  }

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  void dispose() {
    _player.dispose();
  }
}
