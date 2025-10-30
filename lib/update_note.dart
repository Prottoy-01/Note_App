import 'package:flutter/material.dart';

class UpdateNote extends StatefulWidget {
  String title;
  String description;
  UpdateNote({super.key, required this.title, required this.description});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titlecontroller.text = widget.title;
    descriptionController.text = widget.description;
    titlecontroller.selection = TextSelection.fromPosition(
      TextPosition(offset: titlecontroller.text.length),
    );
    descriptionController.selection = TextSelection.fromPosition(
      TextPosition(offset: descriptionController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, {
                'title': titlecontroller.text,
                'description': descriptionController.text,
              });
            },
            icon: Icon(Icons.update, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: titlecontroller,
            cursorColor: Colors.white,
            expands: false,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              //hintText: widget.title,
              //hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: descriptionController,
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                //hintText: widget.description,
                //hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
