import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/notification/notification_model.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class NotificationController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  bool get hasError => errorMessage.isNotEmpty;

  bool get hasNotifications => notifications.isNotEmpty;

  String get emptyMessage => 'No notifications available.';

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading(true);
      errorMessage.value = '';
      // TODO: Implement actual API call to load notifications
      // final response = await notificationRepository.getNotifications();
      // notifications.assignAll(response);
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay
    } catch (e) {
      errorMessage.value = 'Failed to load notifications: $e';
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  void deleteNotification(String id) {
    try {
      // TODO: Implement actual API call to delete notification
      notifications.removeWhere((notification) => notification.id == id);
      AppSnackbar.success('Notification deleted successfully');
    } catch (e) {
      AppSnackbar.error('Failed to delete notification.');
    }
  }

  Future<void> deleteAllNotifications() async {
    try {
      // TODO: Implement actual API call to delete all notifications
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // Simulate API call
      notifications.clear();
      AppSnackbar.success('All notifications deleted successfully');
    } catch (e) {
      AppSnackbar.error('Failed to delete all notifications.');
    }
  }
}
