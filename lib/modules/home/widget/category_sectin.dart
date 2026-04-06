import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/categories/categories_model.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:hkdigiskill/shared/widgets/no_data_widget.dart';

class CategoryGridSection extends StatelessWidget {
  final List<CategoriesModel> categories;
  final VoidCallback onViewAll;
  final bool isLoading;

  const CategoryGridSection({
    super.key,
    required this.categories,
    required this.onViewAll,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with right "view all" action
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Explore Category",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  color: Colors.black,
                  letterSpacing: 0.1,
                ),
              ),
              GestureDetector(
                onTap: onViewAll, // handle view all
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
          ),
        ),
        const SizedBox(height: 8),
        // Grid of category cards
        isLoading
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 90,
                ),
                itemBuilder: (context, index) {
                  return CustomShimmer(
                    isLoading: isLoading,
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: Duration(milliseconds: 400 + index * 80),
                      curve: Curves.easeOutBack,
                      child: AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 400 + index * 80),
                        curve: Curves.easeIn,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF64748B,
                                ).withValues(alpha: 0.2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : categories.isEmpty
            ? NoDataWidget(
                message: "No Categories Found",
                icon: PhosphorIcons.squaresFour(),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 90,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return CustomShimmer(
                    isLoading: isLoading,
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: Duration(milliseconds: 400 + index * 80),
                      curve: Curves.easeOutBack,
                      child: AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 400 + index * 80),
                        curve: Curves.easeIn,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.courses,
                              arguments: {
                                'isFilterMode': true,
                                'categoryId': item.id,
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF64748B,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 18.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${item.courseCount} ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Courses",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      color: AppColors.caption,
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
