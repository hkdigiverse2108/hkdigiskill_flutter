import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/courses/controllers/courses_controller.dart';
import 'package:hkdigiskill/routes/routes.dart';

class ViewAllCourse extends GetView<CoursesController> {
  const ViewAllCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'All Courses',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final course = controller.courses[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.courseDetails, arguments: course);
              },
              child: Container(
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
                                image: NetworkImage(course["image"]),
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
                                    course["duration"],
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
                              course["title"],
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
                                  "(${course["rating"]}/ ${course["ratingCount"]} Ratings)",
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
                              course["price"],
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
                                  "${course["lessons"]} Lessons",
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
                                  "${course["students"]} Students",
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
              ),
            );
          },
          separatorBuilder: (context, index) => Gap(10),
          itemCount: controller.courses.length,
        ),
      ),
    );
  }
}
