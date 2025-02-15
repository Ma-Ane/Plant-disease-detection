
import 'package:flutter/material.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';
import 'package:my_flutter_app/pages/home.dart';
import 'package:my_flutter_app/pages/profile_page.dart';
import 'package:my_flutter_app/pages/search.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav>{

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: const <Widget>[
        NavigationDestination(icon: Icon(Icons.camera_alt_outlined), label: "Search", selectedIcon: Icon(Icons.camera_alt),),
        NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home", selectedIcon: Icon(Icons.home_filled),),
        NavigationDestination(icon: Icon(Icons.person_2_outlined), label: "Profile", selectedIcon: Icon(Icons.person_2),)
      ],
      selectedIndex: currentIndex,
      onDestinationSelected: (int index) => setState(() => currentIndex = index)

      ),
      body: [
        const Search(),
        const Home(),
        const ProfilePage(),
      ][currentIndex],
    );
  }

}