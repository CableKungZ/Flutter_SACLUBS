class ActivityDetailsArguments {
  final String title;
  final String imagePath;
  final String description;
  final bool isJoinable;

  ActivityDetailsArguments({
    required this.title,
    required this.imagePath,
    required this.description,
    this.isJoinable = false,
  });
}

class EditActivityArguments {
  final String title;
  final String description;
  final String imagePath;

  EditActivityArguments({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
