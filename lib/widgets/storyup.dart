
import 'package:flutter/material.dart';

class Storyup extends StatefulWidget {
  final List<Map<String, dynamic>> stories;
  final int initialIndex;

  const Storyup({
    super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  State<Storyup> createState() => _StoryupState();
}

class _StoryupState extends State<Storyup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int currentIndex;

  static const Duration storyDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    _controller = AnimationController(
      vsync: this,
      duration: storyDuration,
    );

    _controller.addStatusListener(_onAnimationStatus);
    _startStory();
  }

  void _startStory() {
    _controller
      ..stop()
      ..reset()
      ..forward();
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _nextStory();
    }
  }

  void _nextStory() {
    if (currentIndex < widget.stories.length - 1) {
      setState(() {
        currentIndex++;
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
      _startStory();
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onAnimationStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[currentIndex];

    final username = story['name'] as String;
    final initial = story['initial'] as String;
    final isMe = story['isMe'] as bool;

    final backgroundColor = isMe
        ? const Color(0xFF34495E)
        : const Color(0xFF833AB4);

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
            // Background Story
            Positioned.fill(
              child: Container(
                color: backgroundColor,
                child: Center(
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 150,
                      color: Colors.white24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Header dan Progress Bar
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    // Progress bar setiap Story
                    Row(
                      children: List.generate(
                        widget.stories.length,
                        (index) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
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

                                  return LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 3,
                                    backgroundColor: Colors.white38,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Header
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
