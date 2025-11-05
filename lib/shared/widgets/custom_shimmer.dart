import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CustomShimmer({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: _buildShimmerPlaceholder(child),
    );
  }

  Widget _buildShimmerPlaceholder(Widget widget) {
    // Text
    if (widget is Text) {
      return Container(
        height: 16,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }
    // Icon
    if (widget is Icon) {
      double size = widget.size ?? 24;
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      );
    }
    // Image (covers Image, Image.network, etc.)
    if (widget is Image) {
      double width = widget.width ?? 48;
      double height = widget.height ?? 48;
      return Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
      );
    }
    // Row
    if (widget is Row) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          mainAxisSize: widget.mainAxisSize,
          children: widget.children.map(_buildShimmerPlaceholder).toList(),
        ),
      );
    }
    // Column
    if (widget is Column) {
      return Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisSize: widget.mainAxisSize,
        children: widget.children.map(_buildShimmerPlaceholder).toList(),
      );
    }
    // Padding
    if (widget is Padding) {
      return Padding(
        padding: widget.padding,
        child: _buildShimmerPlaceholder(widget.child!),
      );
    }
    // Expanded
    if (widget is Expanded) {
      return Expanded(
        flex: widget.flex,
        child: _buildShimmerPlaceholder(widget.child),
      );
    }
    // Container
    if (widget is Container && widget.child != null) {
      return Container(
        margin: widget.margin,
        padding: widget.padding,
        decoration: widget.decoration,
        child: _buildShimmerPlaceholder(widget.child!),
      );
    }
    // SizedBox
    if (widget is SizedBox) {
      // If SizedBox contains a child, shimmer it. Otherwise, empty box.
      if (widget.child != null) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: _buildShimmerPlaceholder(widget.child!),
        );
      }
      return SizedBox(width: widget.width, height: widget.height);
    }
    // Default: pass through non-matching widget
    return widget;
  }
}
