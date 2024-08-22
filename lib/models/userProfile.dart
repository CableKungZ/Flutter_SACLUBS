class UserProfile {
  final String id;
  String name;
  String email;
  String phoneNumber;
  String studentId;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.studentId,
  });
}

class UserProfileManager {
  final Map<String, UserProfile> _profiles = {};

  UserProfile? getProfile(String id) => _profiles[id];

  void updateProfile(UserProfile profile) {
    _profiles[profile.id] = profile;
  }
}
  