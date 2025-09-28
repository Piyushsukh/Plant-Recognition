import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockNotifications();
  }

  void _loadMockNotifications() {
    notifications.addAll([
      {
        'id': '1',
        'title': 'Welcome to PlantID! 🌱',
        'message': 'Start identifying plants by taking photos',
        'time': DateTime.now().subtract(const Duration(minutes: 5)),
        'isRead': false,
        'type': 'info',
      },
      {
        'id': '2',
        'title': 'Tip of the Day',
        'message': 'Make sure plants are well-lit for better identification',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'isRead': false,
        'type': 'info',
      },
    ]);
    _updateUnreadCount();
  }

  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
      _updateUnreadCount();
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    notifications.refresh();
    _updateUnreadCount();
  }

  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !n['isRead']).length;
  }

  void addNotification(String title, String message, String type) {
    notifications.insert(0, {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'message': message,
      'time': DateTime.now(),
      'isRead': false,
      'type': type,
    });
    _updateUnreadCount();
  }
}