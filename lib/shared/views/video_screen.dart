import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/video_controller.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailPage extends GetView<VideoController> {
  const VideoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 8.3,
            child: YoutubePlayer(
              controller: controller.ytController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              onReady: () {},
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.isFullScreen.value
                  ? SizedBox.shrink()
                  : Column(
                      children: [
                        Container(
                          width: width,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                              Obx(
                                () => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha(210),
                                    // 0.82 alpha approx
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        controller.duration.value,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 14,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.title.value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Obx(
                                  () => Text(
                                    controller.description.value,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      height: 1.4,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 17,
                            right: 17,
                            bottom: 18,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF264A73),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // Download handler
                              },
                              child: Text(
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
          ),
        ],
      ),
    );
  }
}
