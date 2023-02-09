import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';
import 'package:src/exports/widgets.dart';

import '/app/app_pages.dart';
import '/widgets/short_fullscreen_tile.dart';
import '/widgets/short_grid_tile.dart';

part 'account_page.dart';
part 'explore_page.dart';
part 'home_page.dart';
part 'inbox_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTabIndex,
        children: const [
          HomePage(),
          ExplorePage(),
          InboxPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedTabIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
            tooltip: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Hộp thư',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cá nhân',
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedTabIndex = index;
          });
        },
      ),
    );
  }
}
