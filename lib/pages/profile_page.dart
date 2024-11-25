import 'package:flutter/material.dart' ;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget _profileOptions (String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom:15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 168, 244, 82),
        ),      
        height: 88,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 20),

            Icon(icon, size: 33,),

            const SizedBox(width: 40),

            Text(name,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ))
          ],
        ),
      ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
        // determine the screen height and width
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: 320,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),

                  ClipOval(
                    child: Image.asset('images/profile_pic.jpg', 
                              fit: BoxFit.cover,
                              height: 170,
                              width: 170,
                    ), 
                  ),
              
                  SizedBox(height: screenHeight * 0.02),

                  const Text("Manjit Maharjan",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
            ),
          ), 

          Padding(
            padding: EdgeInsets.only(top:screenHeight * 0.36, left: 10, right:10),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              height: 520,
              width: double.infinity,
              child: Column(
                children: [
                  _profileOptions("Edit", Icons.edit),
                  _profileOptions("Help", Icons.help),
                  _profileOptions("History", Icons.history),
                  _profileOptions("Contact Us", Icons.contact_mail),
                  _profileOptions("Settings", Icons.settings),
                ]
              ),
            ),
          ),
          
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Padding(
          //     padding: EdgeInsets.only(right: screenWidth * 0.06),
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Icon(Icons.logout, size: 28),
                  
          //         SizedBox(width: 15),
                  
          //         Text("Log out",
          //           style: TextStyle(
          //             fontSize: 24,
          //             fontWeight: FontWeight.w600
          //           ),  
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}