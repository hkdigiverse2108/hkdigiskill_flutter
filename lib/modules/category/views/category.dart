import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TopBar(),
              Gap(20),
              Obx(
                () => (controller.isLoading.value)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _shimmerCard(),
                        separatorBuilder: (context, index) => Gap(10),
                        itemCount: controller.items.length,
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = controller.items[index];
                          return InkWell(
                            onTap: () => controller.onItemTap(id: ""),
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
                                        color: item["bgColor"],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    // Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item["title"],
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
                                            item["count"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            item["description"],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              color: Colors.black.withOpacity(
                                                0.7,
                                              ),
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
                        },
                        separatorBuilder: (context, index) => Gap(10),
                        itemCount: controller.items.length,
                      ),
              ),
            ],
          ),
        ),
      ),
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
