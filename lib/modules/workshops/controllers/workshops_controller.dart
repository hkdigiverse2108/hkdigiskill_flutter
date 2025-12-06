import 'dart:developer';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/workshop/workshop_model.dart';
import 'package:hkdigiskill/app/models/workshop/my_workshop_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/routes/routes.dart';

class WorkshopsController extends GetxController {
  // LOADING STATES
  final isLoading = false.obs;

  // DATA LISTS
  final workshops = <WorkshopModel>[].obs;
  final myWorkshops = <WorkshopPurchaseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllWorkshopData();
  }

  Future<void> loadAllWorkshopData() async {
    isLoading.value = true;

    await fetchAllWorkshops();
    splitPurchasedFromAll();
    await loadRatingsForWorkshops();

    isLoading.value = false;
  }

  Future<void> fetchAllWorkshops() async {
    try {
      final res = await ApiService.to.get(ApiConstants.workshopsEndpoint);

      if (res['status'] == 200) {
        final List data = res['data']['workshop_data'] ?? [];

        workshops.assignAll(
          data.map((e) => WorkshopModel.fromJson(e)).toList(),
        );

        log("All Workshops: ${workshops.length}");
      }
    } catch (e) {
      log("Error fetching workshops: $e");
    }
  }

  void splitPurchasedFromAll() {
    final purchasedList = <WorkshopPurchaseModel>[];

    for (final workshop in workshops) {
      if (workshop.isUnlocked == true) {
        purchasedList.add(WorkshopPurchaseModel(workshop: workshop));
      }
    }

    // Assign purchased list
    myWorkshops.assignAll(purchasedList);

    // Remove purchased workshops from main list
    workshops.removeWhere((w) => w.isUnlocked == true);

    workshops.refresh();
    myWorkshops.refresh();

    log("Purchased Workshops: ${myWorkshops.length}");
    log("Locked Workshops: ${workshops.length}");
  }

  // ---------------------------------------------------------------------------
  // FETCH RATINGS FOR EACH WORKSHOP
  // ---------------------------------------------------------------------------
  Future<void> loadRatingsForWorkshops() async {
    for (int i = 0; i < workshops.length; i++) {
      final workshop = workshops[i];

      if (workshop.id == null) continue;

      final ratingEndpoint = "${ApiConstants.ratingEndpoint}${workshop.id}";
      final res = await ApiService.to.get(ratingEndpoint);

      if (res['status'] == 200) {
        final data = res['data'];

        workshop.averageRating = data["averageRating"] ?? 0;
        workshop.totalRated = data["totalRated"] ?? 0;
      }
    }

    workshops.refresh();
  }

  // ---------------------------------------------------------------------------
  // WORKSHOP DETAILS NAVIGATION
  // ---------------------------------------------------------------------------
  void onWorkshopTap(WorkshopModel workshop) {
    Get.toNamed(Routes.workshopDetails, arguments: workshop);
  }
}
