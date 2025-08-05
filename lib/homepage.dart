import 'package:chatgpt_practice/edit.dart';
import 'package:chatgpt_practice/favorite.dart';
import 'package:chatgpt_practice/note_page.dart';
import 'package:chatgpt_practice/note_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  List<Map<String, String>> notes = [];
  List<int> favorites = [];
  int? currentitems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatGPT Practice')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 250, 250, 249),
        child: Column(
          children: [
            // ✅ Use Expanded to give ListView height
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(notes[index]['title'] ?? 'No Title'),
                        SizedBox(width: 100),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (favorites.contains(index)) {
                                favorites.remove(index);
                              } else {
                                favorites.add(index);
                              }
                            });
                          },
                          icon: Icon(Icons.favorite),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              notes.removeAt(index);
                              if (favorites.contains(index)) {
                                favorites.remove(index);
                              }
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),

                        IconButton(
                          onPressed: () async {
                            final result =
                                await Navigator.push<Map<String, String>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNote(
                                      notes: notes,
                                      currentitems: index,
                                    ),
                                  ),
                                );

                            if (result != null) {
                              setState(() {
                                notes[index] = result;
                              });
                            }
                          },
                          icon: Icon(Icons.edit),
                        ), // Example icon button for favorite action
                        // Add an icon button for favorite action
                      ],
                    ),
                    subtitle: Text(notes[index]['note'] ?? 'No Note'),
                    onTap: () {
                      // Navigate to NoteView page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteView(notes: notes, currentitems: index),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: notes.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (context) => const NotePage()),
          );

          if (result != null) {
            setState(() {
              notes.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Favorite(note: notes, favorites: favorites),
              ),
            );
          }
        },
      ),
    );
  }
}
