import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/modules/gallery/controllers/gallery_controller.dart';
import 'package:hkdigiskill/modules/gallery/views/gallery_details.dart';

class GalleryPage extends GetView<GalleryController> {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gallery',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        itemCount: controller.galleries.length,
        itemBuilder: (ctx, i) {
          final gallery = controller.galleries[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${i + 1}. ${gallery['title']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                GalleryDetailsPage(title: gallery['title']),
                          ),
                        );
                      },
                      child: Text(
                        "view all",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    gallery['images'].length,
                    (j) => Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: _galleryImagePlaceholder(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _galleryImagePlaceholder() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
