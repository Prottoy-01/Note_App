import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  final List<Map<String, String>> note;
  final List<int> favorites;

  const Favorite({super.key, required this.note, required this.favorites});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
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
                  final noteIndex = widget.favorites[index];
                  final note = widget.note[noteIndex];

                  return ListTile(
                    title: Text(note['title'] ?? 'No Title'),
                    subtitle: Text(note['note'] ?? 'No Note'),
                    onTap: () {
                      // Optional: handle tap on favorite item
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.favorites.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
