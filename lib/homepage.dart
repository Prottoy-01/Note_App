import 'package:final_note_app/second_page.dart';
import 'package:final_note_app/update_note.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final noteBox = Hive.box('notes');
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes() {
    final data = noteBox.get('notes', defaultValue: []);

    setState(() {
      notes = (data as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    });
  }

  void addNote() {
    noteBox.put('notes', notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              color: Colors.grey[900],
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            notes[index]['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: PopupMenuButton(
                            iconColor: Colors.white,
                            color: const Color.fromARGB(255, 68, 65, 65),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ];
                            },
                            onSelected: (value) async {
                              if (value == 1) {
                                final updateButtonResult = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateNote(
                                      title: notes[index]['title'],
                                      description: notes[index]['description'],
                                    ),
                                  ),
                                );
                                if (updateButtonResult != null) {
                                  setState(() {
                                    notes[index]['title'] =
                                        updateButtonResult['title'];
                                    notes[index]['description'] =
                                        updateButtonResult['description'];
                                    addNote();
                                  });
                                }
                              }
                              if (value == 2) {
                                notes.removeAt(index);
                                addNote();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        notes[index]['description'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              final columUpdateResult = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateNote(
                    title: notes[index]['title'],
                    description: notes[index]['description'],
                  ),
                ),
              );
              if (columUpdateResult != null) {
                setState(() {
                  notes[index]['title'] = columUpdateResult['title'];
                  notes[index]['description'] =
                      columUpdateResult['description'];
                  addNote();
                });
              }
            },
          );
        },
        itemCount: notes.length,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
          );
          if (result != null) {
            setState(() {
              notes.add(result);
              addNote();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
