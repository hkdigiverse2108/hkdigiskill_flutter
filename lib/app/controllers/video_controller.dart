import 'dart:developer';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  late YoutubePlayerController ytController;

  final title = ''.obs;
  final description = ''.obs;
  final duration = ''.obs;
  final pdf = ''.obs;

  /// Tracks fullscreen mode from YoutubePlayer
  final isFullScreen = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  // -------------------------------
  // Initialize Youtube Player
  // -------------------------------
  void _initializePlayer() {
    try {
      final args = Get.arguments as Map<String, dynamic>? ?? {};

      final videoId =
          args['videoId']?.toString() ?? 'nPt8bK2gbaU'; // fallback ID

      title.value = args['title']?.toString() ?? 'Video Title';
      description.value =
          args['description']?.toString() ?? 'No description available';
      duration.value = args['duration']?.toString() ?? '00:00';
      pdf.value = args['attachment']?.toString() ?? '';

      log("videoId: $videoId");

      ytController = YoutubePlayerController(
        initialVideoId: _extractVideoId(videoId),
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          forceHD: true,
          mute: false,
          enableCaption: true,
          controlsVisibleAtStart: true,
          hideThumbnail: false,
          useHybridComposition: true,
        ),
      );

      ytController.addListener(_playerListener);
    } catch (e) {
      _initializeFallback();
    }
  }

  // -------------------------------
  // Sync fullscreen mode
  // -------------------------------
  void _playerListener() {
    final playerFull = ytController.value.isFullScreen;

    if (playerFull != isFullScreen.value) {
      isFullScreen.value = playerFull;
    }
  }

  String _extractVideoId(String url) {
    try {
      // If already an 11-char YouTube ID
      if (url.length == 11 && !url.contains(RegExp(r'[^A-Za-z0-9_\-]'))) {
        return url;
      }

      // Extract from URL using regex
      final RegExp regExp = RegExp(
        r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|'
        r'(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
        caseSensitive: false,
      );

      final match = regExp.firstMatch(url);
      return match?.group(1) ?? 'nPt8bK2gbaU';
    } catch (_) {
      return 'nPt8bK2gbaU';
    }
  }

  // -------------------------------
  // Fallback if arguments fail
  // -------------------------------
  void _initializeFallback() {
    title.value = 'Video Title';
    description.value = 'No description available.';
    duration.value = '00:00';

    ytController = YoutubePlayerController(
      initialVideoId: 'nPt8bK2gbaU',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        forceHD: true,
        useHybridComposition: true,
      ),
    );

    ytController.addListener(_playerListener);
  }

  // -------------------------------
  // Allow UI to exit fullscreen manually
  // -------------------------------
  void exitFullScreen() {
    if (ytController.value.isFullScreen) {
      ytController.toggleFullScreenMode();
      isFullScreen.value = false;
    }
  }

  void downloadBrochure() async {
    final url = Globals.fixLocalhostUrl(pdf.value);

    if (url.isEmpty) {
      AppSnackbar.error("No PDF available");
      return;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      AppSnackbar.error("Could not open PDF");
    }
  }

  @override
  void onClose() {
    ytController.removeListener(_playerListener);
    ytController.dispose();
    super.onClose();
  }
}
