import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:hkdigiskill/app/controllers/video_controller.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  final VideoController controller = Get.find<VideoController>();
  final RxBool _overlayVisible = true.obs;
  Timer? _overlayTimer;

  static const Duration _overlayDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();

    // start overlay auto-hide when page opens
    _startOverlayTimer();

    // If controller full screen changes from elsewhere, ensure overlay is visible when exiting fullscreen
    ever<bool>(controller.isFullScreen, (isFull) {
      if (!isFull) {
        _showOverlay();
      } else {
        // optionally hide overlay in fullscreen initially
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _overlayTimer?.cancel();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void _startOverlayTimer() {
    _overlayTimer?.cancel();
    _overlayTimer = Timer(_overlayDuration, () {
      _overlayVisible.value = false;
    });
  }

  void _showOverlay() {
    _overlayTimer?.cancel();
    _overlayVisible.value = true;
    _startOverlayTimer();
  }

  void _hideOverlay() {
    _overlayTimer?.cancel();
    _overlayVisible.value = false;
  }

  void _toggleOverlay() {
    if (_overlayVisible.value) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        // If controller says fullscreen, render only the player to avoid overflow
        if (controller.isFullScreen.value) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggleOverlay,
            child: Stack(
              children: [
                // Player takes whole screen
                SizedBox.expand(
                  child: YoutubePlayer(
                    controller: controller.ytController,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    // other YoutubePlayer props...
                  ),
                ),

                // Overlay (back button + small controls) shown/hide
                if (_overlayVisible.value)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back
                          _buildCircleButton(
                            icon: Icons.arrow_back,
                            onTap: () {
                              // exit fullscreen first if your controller handles this,
                              // otherwise pop.
                              if (controller.isFullScreen.value) {
                                // try to exit fullscreen via controller if implemented
                                // otherwise just pop
                                try {
                                  controller.exitFullScreen();
                                } catch (_) {
                                  Get.back();
                                }
                              } else {
                                Get.back();
                              }
                            },
                          ),

                          // Duration chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  controller.duration.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }

        // Normal (not fullscreen) layout
        return Column(
          children: [
            // Player area: aspect ratio fixed but safe for different screens
            GestureDetector(
              onTap: _toggleOverlay,
              behavior: HitTestBehavior.opaque,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    // Youtube player
                    YoutubePlayer(
                      controller: controller.ytController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                      // onReady, etc.
                    ),

                    // Gradient overlay (subtle)
                    Positioned.fill(
                      child: IgnorePointer(
                        ignoring: true,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.35),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Top overlay controls (back + duration) — show/hide with auto-hide
                    Obx(() {
                      if (!_overlayVisible.value)
                        return const SizedBox.shrink();
                      return SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCircleButton(
                                icon: Icons.arrow_back,
                                onTap: () => Get.back(),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      controller.duration.value,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Content below player — keep top-aligned and scrollable
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.title.value,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                height: 1.3,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Obx(
                            () => Text(
                              controller.description.value,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15.5,
                                height: 1.5,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Additional info row (optional)
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.play_circle_outline,
                          //       color: AppColors.primary,
                          //     ),
                          //     const SizedBox(width: 8),
                          //     Text(
                          //       "${controller.totalLessonsDisplay ?? ''}",
                          //       style: const TextStyle(
                          //         fontFamily: 'Poppins',
                          //         fontSize: 13,
                          //       ),
                          //     ),
                          //     // add spacing or other meta here
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),

                  // Download button pinned to bottom
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      bottom: 18,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF264A73),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Download handler
                        },
                        child: const Text(
                          'Download Files',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCircleButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
