import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/home_page.dart';
import 'package:my_flutter_app/pages/profile_page.dart';
import 'package:my_flutter_app/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Color homepageBackground = const Color(0xFF83a84f); 
  final Color homepageBubble = const Color(0xFF3498DB);
  final Color homepageTextbg = const Color(0xFFAFD06E); 

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
    var pagesmap= ['Search Page', 'Home Page', 'Profile Page'];
    return Scaffold(
      appBar: AppBar(
         title:  Text(pagesmap[_selectedIndex]),
         backgroundColor: const Color.fromARGB(255, 104, 125, 145),
       ),
      body: Container(
              height: double.infinity,
              width: double.infinity,

              decoration:const BoxDecoration(
                color: Color.fromARGB(255, 52, 66, 80),
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
      backgroundColor: const Color(0xff344250),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow:  [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, -1),
                blurRadius: 6,
              ),
            ],
          ),
          child: ClipRRect(
             borderRadius: const BorderRadius.all(Radius.circular(12)
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
      ),
    );
  }

}