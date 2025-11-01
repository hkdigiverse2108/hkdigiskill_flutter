import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  late YoutubePlayerController ytController;
  var title = 'Ultimate Design and Art Course'.obs;
  var description =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
          .obs;
  var duration = '03 Hours'.obs;

  var isFullScreen = false.obs;

  @override
  void onInit() {
    super.onInit();
    ytController = YoutubePlayerController(
      initialVideoId: 'nPt8bK2gbaU',
      flags: YoutubePlayerFlags(
        forceHD: true,
        autoPlay: true,
        mute: false,
        hideControls: false,
        controlsVisibleAtStart: true,
        useHybridComposition: true,
      ),
    );

    ytController.addListener(() {
      if (isFullScreen.value != ytController.value.isFullScreen) {
        isFullScreen.value = ytController.value.isFullScreen;
      }
    });
  }

  @override
  void onClose() {
    ytController.dispose();
    super.onClose();
  }
}
