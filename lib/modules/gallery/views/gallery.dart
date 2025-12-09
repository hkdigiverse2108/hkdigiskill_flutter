import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/gallery/controllers/gallery_controller.dart';
import 'package:hkdigiskill/modules/gallery/views/gallery_details.dart';
import 'package:hkdigiskill/modules/gallery/widgets/gallery_animation_wrapper.dart';

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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                itemCount: controller.galleries.length,
                itemBuilder: (ctx, i) {
                  final gallery = controller.galleries[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: GalleryAnimationWrapper(
                      index: i,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${i + 1}. ${gallery.title}",
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
                                      builder: (_) => GalleryDetailsPage(
                                        title: gallery.title,
                                        images: gallery.images,
                                      ),
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
                              gallery.images.length < 4
                                  ? gallery.images.length
                                  : 4,
                              (j) => Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: GalleryItemAnimationWrapper(
                                  index: j,
                                  child: _galleryImagePlaceholder(
                                    gallery.images[j],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _galleryImagePlaceholder(String image) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: NetworkImage(
            Globals.fixLocalhostUrl(image),
            // "https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
