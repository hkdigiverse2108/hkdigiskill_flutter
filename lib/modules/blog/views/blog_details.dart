import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/blog/controllers/blog_details_controller.dart';

class BlogDetailsPage extends GetView<BlogDetailsController> {
  const BlogDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Blog Name',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & meta
            Text(
              controller.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                height: 1.3,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.teal),
                const SizedBox(width: 4),
                Text(
                  controller.date,
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                ),
                const SizedBox(width: 10),
                Icon(Icons.comment, size: 16, color: Colors.teal),
                const SizedBox(width: 4),
                Text(
                  'Com ${controller.comments}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                controller.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              controller.description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 26),
            // Quote block
            Container(
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withOpacity(0.22)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.format_quote, color: Colors.teal),
                      SizedBox(width: 5),
                    ],
                  ),
                  Text(
                    controller.quote,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                      fontStyle: FontStyle.italic,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      controller.quoteAuthor,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Tags row
            Row(
              children: [
                Text(
                  "Tags:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 4),
                ...controller.tags.map(
                  (tag) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(fontSize: 13, color: Colors.teal[700]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Social share row
            Row(
              children: [
                Text(
                  "Share on:",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                SizedBox(width: 8),
                Icon(Icons.facebook, color: AppColors.primary),
                SizedBox(width: 12),
                Icon(Icons.apple, color: AppColors.primary),
                SizedBox(width: 12),
                Icon(Icons.facebook, color: AppColors.primary),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
