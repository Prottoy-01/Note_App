import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  final List<Map<String, String>> notes;
  final int? currentitems;
  const NoteView({super.key, required this.notes, required this.currentitems});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Note View')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 250, 250, 249),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            // int noteIndex = widget.currentitems ?? 0;
            return ListTile(
              title: Text(
                widget.notes[widget.currentitems!]['title'] ?? 'No Title',
              ),
              subtitle: Text(
                widget.notes[widget.currentitems!]['note'] ?? 'No Note',
              ),
            );
          },
        ),
      ),
    );
  }
}
