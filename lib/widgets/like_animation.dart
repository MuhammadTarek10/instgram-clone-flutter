import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smalLike;
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(microseconds: 150),
    this.onEnd,
    this.smalLike = false,
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.duration.inMicroseconds ~/ 2,
      ),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAniamting();
    }
    super.didUpdateWidget(oldWidget);
  }

  void startAniamting() async {
    if (widget.isAnimating || widget.smalLike) {
      await _animationController.forward();
      await _animationController.reverse();
      await Future.delayed(
        const Duration(
          microseconds: 200,
        ),
      );
      if (widget.onEnd != null) {
        _animationController.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
