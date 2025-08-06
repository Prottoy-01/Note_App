import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final int? currentitems;
  final List<Map<String, String>> notes;
  const EditNote({super.key, required this.notes, this.currentitems});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //bool isInitialized = false; // ✅ Used to avoid reset on rebuild

  @override
  Widget build(BuildContext context) {
    // ✅ Set initial text only once
    /* if (!isInitialized && widget.currentitems != null) {
      isInitialized = true;
    }*/
    if (widget.currentitems != null) {
      titleController.text = widget.notes[widget.currentitems!]['title'] ?? '';
      noteController.text = widget.notes[widget.currentitems!]['note'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 244, 245, 247),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Edit your note title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Edit your note',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ✅ Send updated data back
                if (widget.currentitems != null) {
                  Navigator.pop(context, {
                    'title': titleController.text,
                    'note': noteController.text,
                  });
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
