import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // title: Text('Add Note'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                Navigator.pop(context, {
                  'title': titleController.text,
                  'description': descriptionController.text,
                });
              }
            },
            icon: Icon(Icons.save, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              cursorColor: Colors.white,
              controller: titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                //labelText: 'Title'
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 181, 177, 177),
                  fontSize: 20,
                ),
                border: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                controller: descriptionController,
                style: TextStyle(color: Colors.white),
                maxLines: null,
                expands: true,

                decoration: InputDecoration(
                  //labelText: 'Description',
                  hintText: 'Write Your Note',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 181, 177, 177),
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
