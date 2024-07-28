// lib/services/spotify_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/track.dart';

// Replace with your actual token
const String token = 'BQC8oYG3LzdPJHKEfcq_asL-Thz1kYwWkAF3a-eaNFhrO2XuOEAgdOXl83tyQVh7s-TF5RfviMGJYpwHa8VCIFW0mW3g_bt-WCcAzFXMPic09ZKbPdZCEwZVAXZFiNZWMdxXgo8dmXyQ3YJRwfbOOmcLlcBlPpR9Ef43CPdO7EYNsDfjRGHyc0TbeSddoFGC2CZmxWPm5wKPh7RtND7bC_FFeqGZROxisjRO_MwvLe-3I1Wr6KctJrYFfkt7yHOi2YtK5H3CLYYlcKq0finbM9SeJXJtIA';

Future<List<Track>> getRecommendations() async {
  final response = await http.get(
    Uri.parse(
        'https://api.spotify.com/v1/recommendations?limit=5&seed_tracks=0huPIbCmOv7ilzDpEk24q4,1BxfuPKGuaTgP7aM0Bbdwr,1zA5gIh7orj2DZMYxt4hUJ,4P9Q0GojKVXpRTJCaL3kyy,3hUxzQpSfdDqwM3ZTFQY0K'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final tracksJson = json['tracks'] as List;
    return tracksJson.map((trackJson) => Track.fromJson(trackJson)).toList();
  } else {
    throw Exception('Failed to load recommendations');
  }
}

Future<void> likeTrack(String trackId) async {
  final response = await http.put(
    Uri.parse('https://api.spotify.com/v1/me/tracks?ids=$trackId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to like track');
  }
}
