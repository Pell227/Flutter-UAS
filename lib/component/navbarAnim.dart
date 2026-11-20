import 'package:flutter/material.dart';

class AnimatedNavTransitionOverlay extends StatefulWidget {
  final int currentIndex;
  final int itemCount;
  final Widget child; 

  const AnimatedNavTransitionOverlay({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    required this.child,
  });

  @override
  State<AnimatedNavTransitionOverlay> createState() =>
      _AnimatedNavTransitionOverlayState();
}

class _AnimatedNavTransitionOverlayState
    extends State<AnimatedNavTransitionOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void didUpdateWidget(AnimatedNavTransitionOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      if (oldWidget.currentIndex == 0 && widget.currentIndex == 1) {
        _controller.forward(from: 0.0);
      } else if (oldWidget.currentIndex == 1 && widget.currentIndex == 0) {
        _controller.reverse(from: 1.0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = constraints.maxWidth / widget.itemCount;
        final double homeCenterX = itemWidth * 0.5;
        final double friendCenterX = itemWidth * 1.5;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            widget.child,
            AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                if (_slideAnimation.value == 0.0 ||
                    _slideAnimation.value == 1.0) {
                  return const SizedBox.shrink();
                }

                final currentX = Tween<double>(
                  begin: homeCenterX - 12,
                  end: friendCenterX - 12,
                ).evaluate(_slideAnimation);

                // final double verticalArc =
                //     -20.0 * (1.0 - (2.0 * (_slideAnimation.value - 0.5)).abs());

                return Positioned(
                  left: currentX,
                  top: 10,
                  child: Opacity(
                    opacity:
                        (_slideAnimation.value > 0.8 &&
                            widget.currentIndex == 1)
                        ? (1.0 - _slideAnimation.value) * 5
                        : 1.0,
                    child: Icon(Icons.person, color: activeColor, size: 24),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
