import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/routes/routes.dart';

class PopularCoursesSection extends StatelessWidget {
  final List<Map<String, dynamic>> courses;
  final VoidCallback onViewAll;

  const PopularCoursesSection({
    super.key,
    required this.courses,
    required this.onViewAll,
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
              return GestureDetector(
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
                              course["image"],
                              width: width - 40,
                              height: 145,
                              fit: BoxFit.cover,
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
                                color: Color(0xFFFFCE74),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 16,
                                    color: Color(0xFFD17D2A),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    course["duration"],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFD17D2A),
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
                          course["title"],
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
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          children: [
                            ...List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                size: 18,
                                color: Color(0xFFFFB800),
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "(${course["rating"]}/ ${course["ratingCount"]} Ratings)",
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
                          course["price"],
                          style: TextStyle(
                            color: Color(0xFFF05E54),
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
                              "${course["lessons"]} Lessons",
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
                              "${course["students"]} Students",
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
}
