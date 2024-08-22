class Activity {
  final String id;
  String title;
  String description;
  String imageUrl;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class ActivityManager {
  final List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  void addActivity(Activity activity) {
    _activities.add(activity);
  }

  void editActivity(String id, Activity updatedActivity) {
    final index = _activities.indexWhere((activity) => activity.id == id);
    if (index != -1) {
      _activities[index] = updatedActivity;
    }
  }

  void removeActivity(String id) {
    _activities.removeWhere((activity) => activity.id == id);
  }
}
