import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/blog/blog_model.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:hkdigiskill/shared/widgets/no_data_widget.dart';

class PopularBlogsSection extends StatelessWidget {
  final List<BlogModel> blogs;
  final VoidCallback onViewAll;
  final bool isLoading;

  const PopularBlogsSection({
    super.key,
    required this.blogs,
    required this.onViewAll,
    this.isLoading = false,
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
        const SizedBox(height: 10),
        // Blog cards scrollable row
        isLoading
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    3,
                    (index) => const BlogCardShimmer(),
                  ),
                ),
              )
            : blogs.isEmpty
            ? NoDataWidget(
            message: "No Recent Blogs",
            icon: PhosphorIcons.article(),
          )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blogs.map((blog) {
                    return Container(
                      width: 240,
                      height: 260,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF64748B).withValues(alpha: 0.08),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              Globals.fixLocalhostUrl(blog.coverImage),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
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
                                      blog.category,
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
                                      blog.title,
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
                                          color: AppColors.primary,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          Globals.formatDate(blog.updatedAt),
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
                                          // todo: get comments count
                                          "Com 0",
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
                                      blog.content,
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
                                  color: AppColors.primary,
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          Get.toNamed(
                                            Routes.blogDetails,
                                            arguments: blog,
                                          );
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

class BlogCardShimmer extends StatelessWidget {
  const BlogCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 260,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF64748B).withValues(alpha: 0.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Image skeleton
          CustomShimmer(
            isLoading: true,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: 240,
                height: 170,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          // Details card skeleton
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 220,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 14,
                ),
                child: CustomShimmer(
                  isLoading: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category skeleton
                      Container(
                        width: 60,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Title skeleton
                      Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Meta info row skeleton
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 40,
                            height: 11,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Container(
                            width: 8,
                            height: 11,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 36,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Excerpt skeleton
                      Container(
                        width: double.infinity,
                        height: 13,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        width: 140,
                        height: 13,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Forward arrow button skeleton
          Positioned(
            top: 75,
            right: 20,
            child: CustomShimmer(
              isLoading: true,
              child: Material(
                color: Colors.transparent,
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade400,
                    shape: const CircleBorder(),
                  ),
                  child: const SizedBox(width: 42, height: 42),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
