import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/workshop/workshop_model.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/workshops/controllers/workshops_controller.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';
import 'package:hkdigiskill/shared/widgets/no_data_widget.dart';
import 'package:hkdigiskill/shared/widgets/top_bar.dart';

class Workshops extends GetView<WorkshopsController> {
  const Workshops({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              const Gap(20),
              _buildHeader(),
              const Gap(20),
              Obx(
                () => controller.isLoading.value
                    ? _buildShimmerList()
                    : controller.myWorkshops.isEmpty
                    ? NoDataWidget(
                        message: "You Are Not Enrolled In Any Workshop",
                      )
                    : _buildMyWorkshopList(),
              ),
              const Gap(20),
              _buildMoreHeader(),
              const Gap(20),
              Obx(
                () => controller.isLoading.value
                    ? _buildShimmerList()
                    : (controller.workshops.isEmpty)
                    ? NoDataWidget(message: "No Workshops Found")
                    : _buildWorkshopList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      "Enrolled Workshops",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget _buildMoreHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Explore More",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Poppins',
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.viewAllWorkshops);
          }, // handle view all
          child: Text(
            "view all",
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildAnimatedShimmer(index),
      separatorBuilder: (context, index) => const Gap(10),
      itemCount: 3,
    );
  }

  Widget _buildAnimatedShimmer(int index) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 300 + (index * 100)),
      child: _cardShimmer(),
    );
  }

  Widget _cardShimmer() {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 9),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder + badge
          Expanded(
            flex: 3,
            child: CustomShimmer(
              isLoading: true,
              child: Stack(
                children: [
                  // Image skeleton
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Badge skeleton
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Container(
                            width: 40,
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
          ),
          // Details skeleton
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomShimmer(
                isLoading: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title skeleton
                    Container(
                      width: double.infinity,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating skeleton
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 60,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Price skeleton
                    Container(
                      width: 50,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Info row skeleton
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 54,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 54,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkshopList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.workshops.length,
      separatorBuilder: (context, index) => const Gap(10),
      itemBuilder: (context, index) {
        return AnimatedWorkshopCard(
          workshop: controller.workshops[index],
          index: index,
          onTap: () => controller.onWorkshopTap(controller.workshops[index]),
        );
      },
    );
  }

  Widget _buildMyWorkshopList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.myWorkshops.length,
      separatorBuilder: (context, index) => const Gap(10),
      itemBuilder: (context, index) {
        return AnimatedWorkshopCard(
          workshop: controller.myWorkshops[index].workshop!,
          index: index,
          onTap: () =>
              controller.onWorkshopTap(controller.myWorkshops[index].workshop!),
        );
      },
    );
  }
}

class AnimatedWorkshopCard extends StatefulWidget {
  final WorkshopModel workshop;
  final int index;
  final VoidCallback onTap;

  const AnimatedWorkshopCard({
    super.key,
    required this.workshop,
    required this.index,
    required this.onTap,
  });

  @override
  State<AnimatedWorkshopCard> createState() => _AnimatedWorkshopCardState();
}

class _AnimatedWorkshopCardState extends State<AnimatedWorkshopCard>
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
          child: _buildWorkshopCard(),
        ),
      ),
    );
  }

  Widget _buildWorkshopCard() {
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
                      image: NetworkImage(
                        Globals.fixLocalhostUrl(widget.workshop.image!),
                      ),
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
                          widget.workshop.duration ?? "",
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

          // workshop details
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.workshop.title!,
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
                      ...List.generate(5, (index) {
                        final rating = widget.workshop.averageRating ?? 0;

                        return Icon(
                          Icons.star,
                          size: 15,
                          color: index < rating
                              ? const Color(0xFFFFB800)
                              : Colors.grey[300],
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        "(${widget.workshop.averageRating}/ ${widget.workshop.totalRated} Ratings)",
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
                    "₹ ${widget.workshop.price.toString()}",
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
                        "${widget.workshop.workshopCurriculum?.length ?? 0} Chapters",
                        style: TextStyle(
                          color: AppColors.caption,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // const Gap(4),
                      // Text(
                      //   '|',
                      //   style: TextStyle(
                      //     color: AppColors.caption,
                      //     fontSize: 11,
                      //     fontFamily: 'Poppins',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // const Gap(4),
                      // Icon(
                      //   Icons.person_outline_rounded,
                      //   color: AppColors.caption,
                      //   size: 14,
                      // ),
                      // const SizedBox(width: 4),
                      // Text(
                      //   "${widget.workshop.workshopCurriculum?.length ?? 0} Students",
                      //   style: TextStyle(
                      //     color: AppColors.caption,
                      //     fontSize: 11,
                      //     fontFamily: 'Poppins',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
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
