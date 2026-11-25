import 'dart:io';
import 'package:flutter/material.dart';

class Storyup extends StatefulWidget {
  final List<Map<String, dynamic>> stories;
  final int initialIndex;
  final int initialItemIndex;

  const Storyup({
    super.key,
    required this.stories,
    required this.initialIndex,
    this.initialItemIndex = 0,
  });

  @override
  State<Storyup> createState() => _StoryupState();
}

class _StoryupState extends State<Storyup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Map<String, dynamic>> items;

  int currentStoryIndex = 0;
  int currentIndex = 0;

  static const Duration storyDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();

    currentStoryIndex = widget.initialIndex;

    _loadCurrentStory();

    currentIndex = widget.initialItemIndex.clamp(
      0,
      items.isEmpty ? 0 : items.length - 1,
    );

    _controller = AnimationController(
      vsync: this,
      duration: storyDuration,
    );

    _controller.addStatusListener(_onAnimationStatus);

    _startStory();
  }

  void _loadCurrentStory() {
    items = List<Map<String, dynamic>>.from(
      widget.stories[currentStoryIndex]['items'] as List,
    );

    currentIndex = 0;
  }

  void _startStory() {
    if (items.isEmpty) {
      _nextUser();
      return;
    }

    widget.stories[currentStoryIndex]['isViewed'] = true;

    _controller
      ..stop()
      ..reset()
      ..forward();
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      _nextStory();
    }
  }

  void _nextStory() {
    if (currentIndex < items.length - 1) {
      setState(() {
        currentIndex++;
      });

      _startStory();
    } else {
      _nextUser();
    }
  }

  void _nextUser() {
    if (currentStoryIndex < widget.stories.length - 1) {
      setState(() {
        currentStoryIndex++;
        _loadCurrentStory();
      });

      _startStory();
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });

      _startStory();
    } else {
      _previousUser();
    }
  }

  void _previousUser() {
    if (currentStoryIndex > 0) {
      setState(() {
        currentStoryIndex--;
        _loadCurrentStory();
        currentIndex = items.length - 1;
      });

      _startStory();
    } else {
      _controller
        ..stop()
        ..reset()
        ..forward();
    }
  }

  Widget _buildProgressBar(int index) {
    return Expanded(
      child: Container(
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double progress;

            if (index < currentIndex) {
              progress = 1.0;
            } else if (index == currentIndex) {
              progress = _controller.value;
            } else {
              progress = 0.0;
            }

            return Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress,
                heightFactor: 1,
                child: Container(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  // Menampilkan foto atau teks sesuai jenis Story.
  Widget _buildStoryContent(Map<String, dynamic> story) {
    if (story['type'] == 'image') {
      final imagePath = story['imagePath'] as String?;

      if (imagePath == null || imagePath.isEmpty) {
        return const Center(
          child: Text(
            'Foto tidak ditemukan',
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      return SizedBox.expand(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Text(
                'Gagal menampilkan foto',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      );
    }

    final backgroundColor =
        story['color'] as Color? ?? Colors.blueGrey;

    final storyText = story['text'] as String? ?? '';

    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Text(
        storyText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onAnimationStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    final currentUser = widget.stories[currentStoryIndex];

    final username = currentUser['name'] as String;
    final initial = currentUser['initial'] as String;

    final currentStory = items[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: (details) {
          final width = MediaQuery.of(context).size.width;

          if (details.localPosition.dx > width / 2) {
            _nextStory();
          } else {
            _previousStory();
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: _buildStoryContent(currentStory),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: List.generate(
                        items.length,
                        (index) => _buildProgressBar(index),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.white,
                          child: Text(
                            initial,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
