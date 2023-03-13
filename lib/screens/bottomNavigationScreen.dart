import 'package:df_fitness/screens/gym.dart';
import 'package:df_fitness/screens/progress.dart';
import 'package:df_fitness/screens/workOut.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(currentPage),
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Colors.amber[400],
        circleColor: Colors.white,
        activeIconColor: Colors.brown[800],
        inactiveIconColor: Colors.brown[800],
        textColor: Colors.brown[900],
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.search, title: "Search"),
          TabData(iconData: Icons.settings, title: "Settings"),
          TabData(iconData: Icons.shopping_cart, title: "Basket"),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return const Gym();

      case 1:
        return const WorkOut();
      case 2:
        return const Progress();

      default:
        return Container();
    }
  }
}
