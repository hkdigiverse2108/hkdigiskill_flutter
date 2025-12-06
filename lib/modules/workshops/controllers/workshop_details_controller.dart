import 'dart:developer';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/curriculum/curriculum_model.dart';
import 'package:hkdigiskill/app/models/faq/faq_model.dart';
import 'package:hkdigiskill/app/models/lesson/lesson_model.dart';
import 'package:hkdigiskill/app/models/testimonial/testimonial_model.dart';
import 'package:hkdigiskill/app/models/workshop/workshop_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkshopDetailsController extends GetxController {
  final selectedTab = 0.obs;
  var isPurchased = false.obs;
  var isLoading = false.obs;
  var isTestimonialsLoading = false.obs;
  var isLessonsLoading = false.obs;
  var isFaqsLoading = false.obs;
  var curriculumList = <CurriculumModel>[].obs;
  var isCurriculumLoading = false.obs;
  var workshopId = "";
  var workshop = WorkshopModel().obs;
  var testimonials = <TestimonialModel>[].obs;
  var lessons = <LessonModel>[].obs;
  var isWorkshopRatingLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    workshop.value = Get.arguments;
    workshopId = workshop.value.id ?? "";
    getWorkshopDetails();
    getWorkshopRating();
    getCurriculum();
    getTestimonials();
    getFaqs();
  }

  final List<Tabs> tabs = [
    Tabs(title: "About"),
    Tabs(title: "Curriculum"),
    Tabs(title: "Testimonials"),
    Tabs(title: "FAQ's"),
  ];

  final faqs = <FaqModel>[].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> getWorkshopDetails() async {
    try {
      isLoading.value = true;
      final response = await ApiService.to.get(
        '${ApiConstants.workshopByIdEndpoint}/$workshopId',
      );

      log("Workshop Details: $response");

      if (response['status'] == 200 && response['data'] != null) {
        workshop.value = WorkshopModel.fromJson(response['data']);
      } else {
        throw Exception('Failed to load workshop details');
      }
    } catch (e) {
      log('Error fetching workshop details: $e');
      Get.snackbar(
        'Error',
        'Failed to load workshop details',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void getFaqs() async {
    try {
      isFaqsLoading.value = true;
      final response = await ApiService.to.get(
        ApiConstants.getFaqsByWorkshopIdEndpoint(workshopId),
      );

      log(ApiConstants.getFaqsByWorkshopIdEndpoint(workshopId));
      log("Data: $response");
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['faq_data'] ?? [];
        faqs.assignAll(data.map((item) => FaqModel.fromJson(item)).toList());
        log("Faqs: ${faqs.length}");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load FAQs',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isFaqsLoading.value = false;
    }
  }

  void getTestimonials() async {
    try {
      isTestimonialsLoading.value = true;
      final response = await ApiService.to.get(
        ApiConstants.getTestimonialsByWorkshopIdEndpoint(workshopId),
      );

      log(ApiConstants.getTestimonialsByWorkshopIdEndpoint(workshopId));
      log("Data: $response");
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['testimonial_data'] ?? [];
        testimonials.assignAll(
          data.map((item) => TestimonialModel.fromJson(item)).toList(),
        );
        log("Testimonials: ${testimonials.length}");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load testimonials',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isTestimonialsLoading.value = false;
    }
  }

  void getCurriculum() async {
    try {
      isCurriculumLoading.value = true;

      final response = await ApiService.to.get(
        ApiConstants.getWorkshopCurriculumEndpoint + workshopId,
      );

      if (response['status'] == 200) {
        final List<dynamic> data =
            response['data']['workshop_curriculum_data'] ?? [];

        final parsed = data
            .map((item) => CurriculumModel.fromJson(item))
            .toList();

        curriculumList.assignAll(parsed);
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load curriculum',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCurriculumLoading.value = false;
    }
  }

  getWorkshopRating() async {
    try {
      isWorkshopRatingLoading.value = true;
      final response = await ApiService.to.get(
        ApiConstants.ratingEndpoint + workshopId,
      );

      log("Rating for Workshop $workshopId: $response");

      if (response['status'] == 200) {
        final data = response['data'];

        workshop.value.averageRating = data["averageRating"] ?? 0;
        workshop.value.totalRated = data["totalRated"] ?? 0;
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load workshop rating',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isWorkshopRatingLoading.value = false;
    }
  }

  void downloadBrochure() async {
    final url = Globals.fixLocalhostUrl(workshop.value.pdfAttach ?? "");

    if (url.isEmpty) {
      Get.snackbar("Error", "No brochure available");
      return;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Unable to open brochure");
    }
  }
}

class Tabs {
  final String title;

  Tabs({required this.title});
}
