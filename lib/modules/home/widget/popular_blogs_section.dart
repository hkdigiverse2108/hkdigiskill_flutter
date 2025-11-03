import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/routes/routes.dart';

class PopularBlogsSection extends StatelessWidget {
  final List<Map<String, dynamic>> blogs;
  final VoidCallback onViewAll;

  const PopularBlogsSection({
    super.key,
    required this.blogs,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
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
                "Popular Blogs",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  color: Colors.black,
                  letterSpacing: 0.1,
                ),
              ),
              GestureDetector(
                onTap: () {}, // handle view all
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
        // Blog cards scrollable row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: blogs.map((blog) {
              return Container(
                width: 240,
                height: 260,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF64748B).withOpacity(0.08),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        blog["image"],
                        width: 240,
                        height: 170,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 240,
                            height: 170,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: 220,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category
                              Text(
                                blog["category"],
                                style: const TextStyle(
                                  color: Color(0xFF838D9A),
                                  fontSize: 11.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Title
                              Text(
                                blog["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Color(0xFF263245),
                                  height: 1.19,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Meta info (date and comments)
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_note,
                                    color: AppColors.info,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    blog["date"],
                                    style: TextStyle(
                                      color: AppColors.caption,
                                      fontFamily: 'Poppins',
                                      fontSize: 11.8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '|',
                                    style: TextStyle(
                                      color: AppColors.caption,
                                      fontSize: 11.8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.mode_comment_outlined,
                                    color: AppColors.caption,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Com ${blog["comments"]}",
                                    style: TextStyle(
                                      color: AppColors.caption,
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Excerpt (optional)
                              Text(
                                blog["excerpt"],
                                style: const TextStyle(
                                  color: Color(0xFF838D9A),
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 75,
                      right: 20,
                      child: Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: Color(0xFF21BAA8),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 22,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.blogDetails);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
