import 'package:flutter/material.dart';
import 'package:samacharpatra/features/home/presentation/pages/home_page.dart';
import 'package:samacharpatra/features/saved/presentation/pages/saved_page.dart';
import 'package:samacharpatra/features/setting/presentation/pages/setting_page.dart';

import '../search/presentation/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // variables
  int _currentIndex = 0;

  final _pages = [HomePage(), SearchPage(), SavedPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 26.0,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        elevation: 3,
        backgroundColor: Theme.of(context).canvasColor,
        onTap:
            (newIndex) => setState(() {
              _currentIndex = newIndex;
            }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border_rounded), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Setting'),
        ],
      ),
    );
  }
}
