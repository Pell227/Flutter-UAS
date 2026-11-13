import 'package:flutter/material.dart';

class AnimatedNavbarDemo extends StatefulWidget {
  const AnimatedNavbarDemo({super.key});

  @override
  State<AnimatedNavbarDemo> createState() => _AnimatedNavbarDemoState();
}

class _AnimatedNavbarDemoState extends State<AnimatedNavbarDemo> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    
    // Controls the travel progress from Home (0.0) to Friends (1.0)
    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      // Going to Friends: Animate person leaving Home towards Friends
      _controller.forward();
    } else {
      // Going back to Home: Reverse animation
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _currentIndex == 0 ? "Home Screen (The House)" : "Friends Screen",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate approximate X offsets for the two tabs
            // Assuming 2 items taking equal width
            final double itemWidth = constraints.maxWidth / 2;
            final double homeCenterX = itemWidth * 0.5;
            final double friendCenterX = itemWidth * 1.5;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Base Navigation Icons Row
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _onItemTapped(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                            ),
                            const Text("Home", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _onItemTapped(1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // When fully arrived, show 2 persons, otherwise 1 person or morph
                            Icon(
                              _currentIndex == 1 ? Icons.people : Icons.person,
                              color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                            ),
                            const Text("Friends", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // 2. The Sliding "Traveler" Icon Overlay
                AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    // Interpolate X position between Home and Friends center
                    final currentX = Tween<double>(
                      begin: homeCenterX - 12, // center alignment offset
                      end: friendCenterX - 12,
                    ).evaluate(_slideAnimation);

                    // Optional: Make it lift up into the air slightly during transit (Arc effect)
                    final double verticalArc = -20.0 * (1.0 - (2.0 * (_slideAnimation.value - 0.5)).abs());

                    return Positioned(
                      left: currentX,
                      top: 10 + verticalArc,
                      child: Opacity(
                        // Fade out near the destination as it merges into the 2-person icon
                        opacity: (_slideAnimation.value > 0.8 && _currentIndex == 1) ? (1.0 - _slideAnimation.value) * 5 : 1.0,
                        child: const Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}