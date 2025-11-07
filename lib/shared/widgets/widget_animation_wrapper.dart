import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// All available animation styles.
enum AnimationType { fade, slide, scale, rotate }

/// Entry directions for slide animations.
enum SlideDirection { fromLeft, fromRight, fromTop, fromBottom }

class WidgetAnimationWrapper extends StatefulWidget {
  final Widget child;
  final int index;
  final List<AnimationType> animationTypes;

  final Duration duration;
  final Curve curve;
  final bool enableStagger;
  final bool isScrollDetection; // 👈 triggers only when visible
  final double scaleOffset;
  final SlideDirection slideDirection;
  final double rotateOffset;
  final double fadeOffset;
  final double slideOffset; // how far slide should start (0.0–1.0)

  const WidgetAnimationWrapper({
    super.key,
    required this.child,
    required this.index,
    this.animationTypes = const [AnimationType.fade],
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOut,
    this.enableStagger = true,
    this.isScrollDetection = false,
    this.slideDirection = SlideDirection.fromBottom,
    this.slideOffset = 0.1,
    this.scaleOffset = 0.95,
    this.rotateOffset = -0.05,
    this.fadeOffset = 0.0,
  });

  @override
  State<WidgetAnimationWrapper> createState() => _WidgetAnimationWrapperState();
}

class _WidgetAnimationWrapperState extends State<WidgetAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;
  late final Animation<double> _rotate;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);

    _fade = Tween<double>(begin: widget.fadeOffset, end: 1).animate(curved);
    _scale = Tween<double>(begin: widget.scaleOffset, end: 1).animate(curved);
    _rotate = Tween<double>(begin: widget.rotateOffset, end: 0).animate(curved);

    // Slide offset direction
    final beginOffset = switch (widget.slideDirection) {
      SlideDirection.fromLeft => Offset(-widget.slideOffset, 0),
      SlideDirection.fromRight => Offset(widget.slideOffset, 0),
      SlideDirection.fromTop => Offset(0, -widget.slideOffset),
      SlideDirection.fromBottom => Offset(0, widget.slideOffset),
    };

    _slide = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(curved);

    // Start animation immediately if scroll detection is off
    if (!widget.isScrollDetection) _startAnimation();
  }

  void _startAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;

    // ⏱ Disable delay if scroll detection is enabled (for better UX)
    final delay = (!widget.isScrollDetection && widget.enableStagger)
        ? Duration(milliseconds: 80 + (widget.index * 60))
        : Duration.zero;

    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _applyAnimations(Widget child) {
    // Apply multiple animations by nesting transitions
    Widget animatedChild = child;

    if (widget.animationTypes.contains(AnimationType.slide)) {
      animatedChild = SlideTransition(position: _slide, child: animatedChild);
    }
    if (widget.animationTypes.contains(AnimationType.scale)) {
      animatedChild = ScaleTransition(scale: _scale, child: animatedChild);
    }
    if (widget.animationTypes.contains(AnimationType.rotate)) {
      animatedChild = RotationTransition(turns: _rotate, child: animatedChild);
    }
    if (widget.animationTypes.contains(AnimationType.fade)) {
      animatedChild = FadeTransition(opacity: _fade, child: animatedChild);
    }

    return animatedChild;
  }

  @override
  Widget build(BuildContext context) {
    final animatedChild = _applyAnimations(widget.child);

    if (widget.isScrollDetection) {
      return VisibilityDetector(
        key: Key('anim_${widget.index}_${widget.hashCode}'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.1) {
            _startAnimation();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => animatedChild,
        ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => animatedChild,
    );
  }
}
