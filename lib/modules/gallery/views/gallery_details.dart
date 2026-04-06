import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
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
    return GestureDetector(
      onTap: () {
        Get.to(
          () => GalleryPhotoViewWrapper(
            galleryItems: images,
            initialIndex: images.indexOf(image),
          ),
        );
      },
      child: Hero(
        tag: image,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(Globals.fixLocalhostUrl(image)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  final List<String> galleryItems;
  final int initialIndex;

  GalleryPhotoViewWrapper({
    super.key,
    required this.galleryItems,
    this.initialIndex = 0,
  }) : pageController = PageController(initialPage: initialIndex);

  final PageController pageController;

  @override
  State<StatefulWidget> createState() => _GalleryPhotoViewWrapperState();
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                  Globals.fixLocalhostUrl(widget.galleryItems[index]),
                ),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.galleryItems[index],
                ),
              );
            },
            itemCount: widget.galleryItems.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes ?? 1),
                ),
              ),
            ),
            pageController: widget.pageController,
            onPageChanged: onPageChanged,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              '${currentIndex + 1} of ${widget.galleryItems.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                decoration: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
