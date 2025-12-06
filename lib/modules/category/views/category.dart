import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/categories/categories_model.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/category/controllers/category_controller.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';
import 'package:hkdigiskill/shared/widgets/top_bar.dart';

class Category extends GetView<CategoryController> {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const TopBar(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.9),
                      // 0% opaque at top
                      Colors.transparent,
                      // 100% opaque around 15%
                      Colors.transparent,
                      // 100% opaque
                      Colors.white.withValues(alpha: 0.9),
                      // 0% opaque at bottom
                    ],
                    stops: [0, 0.12, 0.88, 1.0],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: Obx(
                  () => controller.isLoading.value
                      ? _buildShimmerList()
                      : _buildCategoryList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: 8,
      itemBuilder: (context, index) {
        return AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 300 + (index * 100)),
          child: _shimmerCard(),
        );
      },
      separatorBuilder: (context, index) {
        return const Gap(16);
      },
    );
  }

  Widget _buildCategoryList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        return AnimatedCategoryItem(
          item: controller.items[index],
          index: index,
          onTap: () => controller.onItemTap(id: controller.items[index].id),
        );
      },
      separatorBuilder: (context, index) {
        return const Gap(16);
      },
    );
  }

  Widget _shimmerCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar/colored square placeholder
            CustomShimmer(
              isLoading: true,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(width: 16),
            // Details placeholder
            Expanded(
              child: CustomShimmer(
                isLoading: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Count
                    Container(
                      width: 60,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Description (simulate multiple lines)
                    Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: 180,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
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

class AnimatedCategoryItem extends StatefulWidget {
  final CategoriesModel item;
  final int index;
  final VoidCallback onTap;

  const AnimatedCategoryItem({
    super.key,
    required this.item,
    required this.index,
    required this.onTap,
  });

  @override
  State<AnimatedCategoryItem> createState() => _AnimatedCategoryItemState();
}

class _AnimatedCategoryItemState extends State<AnimatedCategoryItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

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
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    // Start animation after a small delay based on index
    Future.delayed(Duration(milliseconds: 100 + (widget.index * 50)), () {
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
      child: _buildCategoryItem(),
    );
  }

  Widget _buildCategoryItem() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Colored square/avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE7E3),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  Globals.fixLocalhostUrl(widget.item.image ?? ""),
                  fit: BoxFit.cover,

                  // 🔥 ERROR HANDLER
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFFDE7E3),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_rounded,
                        color: Colors.grey,
                        size: 32,
                      ),
                    );
                  },

                  // 🔥 OPTIONAL LOADING PLACEHOLDER
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: const Color(0xFFFDE7E3),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                ),
              ),

              SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),

                    SizedBox(height: 4),
                    Text(
                      // todo: add count
                      "${widget.item.courseCount} Courses",
                      // widget.item.count,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      widget.item.description,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: Colors.black.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
