import 'package:flutter/material.dart';

class EditActivityScreen extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;

  const EditActivityScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  _EditActivityScreenState createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imagePathController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _imagePathController = TextEditingController(text: widget.imagePath);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imagePathController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Handle save changes logic
    final updatedTitle = _titleController.text;
    final updatedDescription = _descriptionController.text;
    final updatedImagePath = _imagePathController.text;

    // Implement your logic to save the updated activity details
    // For example, update the database or send a request to an API
  }

  void _deleteActivity() {
    // Handle delete activity logic
    // Implement your logic to delete the activity
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Activity'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteActivity,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Activity Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: _descriptionController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Image URL'),
              controller: _imagePathController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Save Changes'),
              onPressed: _saveChanges,
            ),
          ],
        ),
      ),
    );
  }
}
