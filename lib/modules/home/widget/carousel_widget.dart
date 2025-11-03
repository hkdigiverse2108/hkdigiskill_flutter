import 'package:flutter/material.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';

class ImageCardCarousel extends StatefulWidget {
  final List<String> imageList;

  const ImageCardCarousel({super.key, required this.imageList});

  @override
  State<ImageCardCarousel> createState() => _ImageCardCarouselState();
}

class _ImageCardCarouselState extends State<ImageCardCarousel> {
  int _currentPage = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image card
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            color: AppColors.backgroundLight,
            width: double.infinity,
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageList.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      color: AppColors.backgroundLight,
                      width: double.infinity,
                      height: 180,
                      child: Image.network(
                        widget.imageList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, progress) =>
                            progress == null
                            ? child
                            : Center(child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          height: 180,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Page indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.imageList.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: index == _currentPage ? 10 : 7,
              height: index == _currentPage ? 10 : 7,
              decoration: BoxDecoration(
                color: index == _currentPage
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(7),
              ),
            );
          }),
        ),
      ],
    );
  }
}
