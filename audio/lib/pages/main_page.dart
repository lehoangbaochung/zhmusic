import 'package:audio/pages/library_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LibraryPage(),
      bottomSheet: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        title: const Text('Một bài cổ phong nghĩ không thông'),
        subtitle: const Text('Huyền Thương'),
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          child: Center(
            child: Icon(Icons.favorite),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.playlist_play),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            label: 'Khám phá',
            icon: Icon(Icons.explore),
          ),
          BottomNavigationBarItem(
            label: 'Thư viện',
            icon: Icon(Icons.library_music),
          ),
        ],
      ),
    );
  }
}
