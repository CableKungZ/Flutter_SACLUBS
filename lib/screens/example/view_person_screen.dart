import 'package:flutter/material.dart';
import '../../models/contact.dart';

class ViewPersonScreen extends StatefulWidget {
  const ViewPersonScreen({super.key});

  // const ViewPersonScreen({super.key});

  @override
  State<ViewPersonScreen> createState() => _ViewPersonScreenState();
}

class _ViewPersonScreenState extends State<ViewPersonScreen> {
  @override
  Widget build(BuildContext context) {
    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${contact.name}'),
            const SizedBox(height: 10),
            Text('Phone Number: ${contact.phoneNumber}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/edit_person', arguments: contact);
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
