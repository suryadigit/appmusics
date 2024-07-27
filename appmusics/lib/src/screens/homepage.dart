import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isPlaying = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      value: 0.0,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _rotationController.stop();
      } else {
        _rotationController.repeat();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _previousSong() {
    // Implement previous song functionality here
  }

  void _nextSong() {
    // Implement next song functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 54.0, left: 16.0, right: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari dan dengarkan musik favoritmu',
                hintStyle: TextStyle(color: Colors.grey[800]),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                fillColor: Colors.grey[150],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 20.0),
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2.0 * 3.14,
                    child: child,
                  );
                },
                child: const CircleAvatar(
                  radius: 120.0,
                  
                ),
              ),
              Positioned(
                left: 20.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  onPressed: _previousSong,
                ),
              ),
              Positioned(
                right: 20.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.skip_next,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  onPressed: _nextSong,
                ),
              ),
              Positioned(
                child: IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  onPressed: _togglePlayPause,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: LinearProgressIndicator(
              value: _isPlaying ? null : 0.0,
              backgroundColor: Colors.grey[300],
              color: Colors.deepPurple,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: const [
                // Add your list items here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
