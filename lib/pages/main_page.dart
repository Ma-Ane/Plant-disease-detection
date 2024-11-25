import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/after_detection.dart';
import 'package:my_flutter_app/pages/home_page.dart';
import 'package:my_flutter_app/pages/profile_page.dart';
import 'package:my_flutter_app/pages/search_page.dart';
// import 'package:plant_disease/pages/search_page.dart';
//import 'package:plant_disease/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    final Color primaryColor = Color(0xFFA6BC36); // Hex color for blue
  final Color secondaryColor = Color(0xFF3498DB); // Hex color for blue
  final Color thirdColor = Color(0xFF3498DB); 

  int _selectedIndex = 1 ;

  void _onItemTapped (int index) {
    setState(() {
      _selectedIndex = index ;
    });
  }

  Widget _changeContentMainPage (int index) {
      switch (index) {
        case 0:
          //return const SearchPage();
          return const SearchPage();

        case 1:
          return const HomePage() ;

        case 2:
          return const ProfilePage();

        default:
          return const Text("") ;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Main Page'),
      // ),
      body: Container(
              height: double.infinity,
              width: double.infinity,

              decoration: BoxDecoration(
                color: primaryColor,
                // edi color use garne bhaye
                // // gradient: LinearGradient(
                // //   colors:[
                // //     Color(0xFF17E0BC),
                // //     Color(0xFF98CE00),
                // //   ],
                // //   begin: Alignment.topLeft,
                // //   end: Alignment.bottomRight,
                // // )

              // edi image uyse garne bhayee
                // image: DecorationImage(
                //   image: AssetImage('images/background3.jpg'), // Your image path
                //   fit: BoxFit.cover, // Cover the entire background
                // ),
              ),
        child: Center(
          child: _changeContentMainPage(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: const Border(
              top: BorderSide(color: Colors.grey, width: 2), // Top border

            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, -1),
                blurRadius: 6,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,        // this is needed to change the index value
            backgroundColor: Colors.green[50], // Background color of the bar
            selectedItemColor: Colors.green,   // Color for the selected item
            unselectedItemColor: Colors.grey, // Color for unselected items
            showUnselectedLabels: true,       // Show labels for unselected items
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

}