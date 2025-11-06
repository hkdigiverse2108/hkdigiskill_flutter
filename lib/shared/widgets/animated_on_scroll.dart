import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offsetY; // interpreted as pixels now
  final Curve curve;
  final bool animateOnce;
  final String? semanticLabel;

  const AnimatedOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.offsetY = 30.0, // default: 30 pixels downward
    this.curve = Curves.easeOutCubic,
    this.animateOnce = true,
    this.semanticLabel,
  });

  @override
  State<AnimatedOnScroll> createState() => _AnimatedOnScrollState();
}

class _AnimatedOnScrollState extends State<AnimatedOnScroll>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.1 && !_isVisible) {
      setState(() => _isVisible = true);
    } else if (info.visibleFraction <= 0.0 &&
        !widget.animateOnce &&
        _isVisible) {
      setState(() => _isVisible = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('${widget.child.runtimeType}-${widget.child.hashCode}'),
      onVisibilityChanged: _handleVisibilityChanged,
      child: AnimatedSlide(
        offset: _isVisible
            ? Offset.zero
            : Offset(0, widget.offsetY / (MediaQuery.of(context).size.height)),
        duration: widget.duration,
        curve: widget.curve,
        child: AnimatedOpacity(
          opacity: _isVisible ? 1 : 0.2,
          duration: widget.duration,
          curve: widget.curve,
          child: widget.semanticLabel != null
              ? Semantics(label: widget.semanticLabel, child: widget.child)
              : widget.child,
        ),
      ),
    );
  }
}
