import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';


class BottomBar extends StatelessWidget {
  final PageController _pageController;
  const BottomBar(this._pageController, {Key? key, title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {

      final notifier = ref.read(homePageProvider.notifier);
      
      return BottomNavigationBar(
        currentIndex: notifier.state.selectedIndex,
        onTap: (index) {
          if (_pageController.hasClients) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeOut);
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            activeIcon: Icon(Icons.house),
            label: 'Home',
            tooltip: "This is a Book Page",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fireplace),
            activeIcon: Icon(Icons.fireplace),
            label: 'Battle',
            tooltip: "This is a Business Page",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books_outlined),
            label: 'History',
            tooltip: "This is a School Page",
            backgroundColor: Colors.blue,
          ),
        ],

        // type: BottomNavigationBarType.shifting,
        // backgroundColor: Colors.blue,
        enableFeedback: true,
        // iconSize: 18,
        // selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(size: 25, color: Colors.blue),
        // selectedLabelStyle: const TextStyle(color: Colors.white),
        // selectedItemColor: Colors.white,
        // unselectedFontSize: 15,
        unselectedIconTheme: const IconThemeData(size: 25, color: Colors.blue),
        // unselectedLabelStyle: const TextStyle(color: Colors.white),
        // unselectedItemColor: Colors.white,

      );
    });
  }
}