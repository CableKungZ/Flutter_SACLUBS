class Notification {
  final String id;
  final String message;
  final DateTime timestamp;

  Notification({
    required this.id,
    required this.message,
    required this.timestamp,
  });
}

class NotificationManager {
  final List<Notification> _notifications = [];

  List<Notification> get notifications => _notifications;

  void addNotification(Notification notification) {
    _notifications.add(notification);
  }

  void removeNotification(String id) {
    _notifications.removeWhere((notification) => notification.id == id);
  }
}
