import 'package:flutter/material.dart';

class BlogAnimationWrapper extends StatefulWidget {
  final Widget child;
  final int index;

  const BlogAnimationWrapper({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<BlogAnimationWrapper> createState() => _BlogAnimationWrapperState();
}

class _BlogAnimationWrapperState extends State<BlogAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300 + (widget.index * 50)),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start animation after a short staggered delay based on index
    Future.delayed(Duration(milliseconds: 80 + (widget.index * 50)), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(opacity: _opacityAnimation, child: child);
      },
      child: widget.child,
    );
  }
}
