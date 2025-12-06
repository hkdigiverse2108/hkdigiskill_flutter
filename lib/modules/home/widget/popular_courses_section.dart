import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/courses/course_models.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';

class PopularCoursesSection extends StatelessWidget {
  final List<CourseModel> courses;
  final VoidCallback onViewAll;
  final bool isLoading;

  const PopularCoursesSection({
    super.key,
    required this.courses,
    required this.onViewAll,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Popular Courses",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  color: Colors.black,
                  letterSpacing: 0.1,
                ),
              ),
              GestureDetector(
                onTap: onViewAll,
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
        const SizedBox(height: 10),
        SizedBox(
          height: 320,
          width: double.infinity,
          child: PageView.builder(
            controller: pageController,
            itemCount: courses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final course = courses[index];
              return (isLoading)
                  ? verticalCardShimmer(width)
                  : GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.courseDetails, arguments: course);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF64748B).withOpacity(0.08),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Only image and badge are stacked
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    Globals.fixLocalhostUrl(course.image ?? ""),
                                    width: width - 40,
                                    height: 145,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: width - 40,
                                        height: 145,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 16,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          Globals.convertMinutesToHoursDays(
                                            course.duration ?? 0,
                                          ),
                                          style: TextStyle(
                                            fontSize: 13,
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
                            // Card content (all normal column)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 18, 14, 3),
                              child: Text(
                                course.name ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF263245),
                                  height: 1.25,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                              ),
                              child: Row(
                                children: [
                                  // ⭐ Dynamic stars (filled based on rating)
                                  ...List.generate(5, (index) {
                                    final rating = course.averageRating ?? 0;

                                    return Icon(
                                      Icons.star,
                                      size: 18,
                                      color: index < rating
                                          ? const Color(0xFFFFB800)
                                          : Colors.grey[300],
                                    );
                                  }),

                                  const SizedBox(width: 6),

                                  // ⭐ Rating Text
                                  Text(
                                    "(${(course.averageRating ?? 0).toStringAsFixed(1)} / ${(course.totalRated ?? 0)} Ratings)",
                                    style: TextStyle(
                                      color: AppColors.caption,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 14.0,
                                right: 14,
                                top: 3,
                                bottom: 2,
                              ),
                              child: Text(
                                course.price == null ? "" : "₹${course.price}",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 5, 14, 14),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.menu_book_outlined,
                                    color: AppColors.caption,
                                    size: 17,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${course.totalLesson} Lessons",
                                    style: TextStyle(
                                      color: AppColors.caption,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 9),
                                  Text('|'),
                                  SizedBox(width: 9),
                                  Icon(
                                    Icons.person_outline_rounded,
                                    color: AppColors.caption,
                                    size: 17,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${course.enrolledLearners} Students",
                                    style: TextStyle(
                                      color: AppColors.caption,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget verticalCardShimmer(double width) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Color(0xFF64748B).withOpacity(0.08), blurRadius: 10),
        ],
      ),
      child: CustomShimmer(
        isLoading: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image & badge skeleton
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    width: width - 40,
                    height: 145,
                    color: Colors.grey.shade400,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Container(
                          width: 48,
                          height: 13,
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
            // Title skeleton
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 18, 14, 3),
              child: SizedBox(
                height: 16,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Ratings skeleton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  ...List.generate(
                    5,
                    (index) => Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 86,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Price skeleton
            const Padding(
              padding: EdgeInsets.only(
                left: 14.0,
                right: 14,
                top: 3,
                bottom: 2,
              ),
              child: SizedBox(
                height: 16,
                width: 80,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Lessons and students skeleton
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 5, 14, 14),
              child: Row(
                children: [
                  Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 70,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Container(
                    width: 12,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 70,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
