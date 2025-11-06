import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';

class AnimatedCourseCard extends StatefulWidget {
  final Map<String, dynamic> course;
  final int index;
  final VoidCallback onTap;

  const AnimatedCourseCard({
    super.key,
    required this.course,
    required this.index,
    required this.onTap,
  });

  @override
  State<AnimatedCourseCard> createState() => _AnimatedCourseCardState();
}

class _AnimatedCourseCardState extends State<AnimatedCourseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 + (widget.index * 100)),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    // Start animation after a small delay based on index
    Future.delayed(Duration(milliseconds: 100 + (widget.index * 100)), () {
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
        return FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(position: _slideAnimation, child: child),
        );
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isTapped = true);
          widget.onTap();
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() => _isTapped = false);
            }
          });
        },
        child: Transform.scale(
          scale: _isTapped ? 0.98 : 1.0,
          child: _buildCourseCard(),
        ),
      ),
    );
  }

  Widget _buildCourseCard() {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF64748B).withValues(alpha: 0.2),
            blurRadius: 9,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + badge
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(widget.course["image"]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          widget.course["duration"],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Course details
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.course["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Color(0xFF263245),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // ratings
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 15,
                          color: Color(0xFFFFB800),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${widget.course["rating"]}/ ${widget.course["ratingCount"]} Ratings)",
                        style: TextStyle(
                          color: AppColors.caption,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // price
                  Text(
                    widget.course["price"],
                    style: TextStyle(
                      color: Color(0xFFF05E54),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // lessons and students
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        color: AppColors.caption,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.course["lessons"]} Lessons",
                        style: TextStyle(
                          color: AppColors.caption,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '|',
                        style: TextStyle(
                          color: AppColors.caption,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(4),
                      Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.caption,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.course["students"]} Students",
                        style: TextStyle(
                          color: AppColors.caption,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
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
    );
  }
}
