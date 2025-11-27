import 'package:flutter/material.dart';
import 'package:hkdigiskill/modules/gallery/widgets/gallery_animation_wrapper.dart';

class GalleryDetailsPage extends StatelessWidget {
  final String title;
  final List<String> images;

  const GalleryDetailsPage({
    super.key,
    required this.title,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    // For demo, 8 images

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1,
          ),
          itemBuilder: (ctx, i) => GalleryItemAnimationWrapper(
            index: i,
            child: _galleryImagePlaceholder(images[i]),
          ),
        ),
      ),
    );
  }

  Widget _galleryImagePlaceholder(String image) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
