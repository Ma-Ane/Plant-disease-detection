import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/help.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget _profileOptions (String name, IconData icon, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;
    return Padding(
      padding:  EdgeInsets.only(bottom:screenHeight * 0.02),
      child: GestureDetector(
        onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => const Help()))},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 63, 155, 104),
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
      ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
        // determine the screen height and width
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 52, 66, 80),
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 52, 66, 80),
            height: 320,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),

                  ClipOval(
                    child: Image.asset('images/profile_pic.jpg', 
                              fit: BoxFit.cover,
                              height: screenWidth * 0.25,
                              width: screenWidth * 0.25,
                    ), 
                  ),
              
                  SizedBox(height: screenHeight * 0.02),

                  const Text("Manjit Maharjan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
            ),
          ), 

          Padding(
            padding: EdgeInsets.only(top:screenHeight * 0.25, left: 10, right:10),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 52, 66, 80),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  _profileOptions("Edit", Icons.edit,context),
                  _profileOptions("Help", Icons.help,context),
                  _profileOptions("History", Icons.history,context),
                  _profileOptions("Contact Us", Icons.contact_mail,context),
                  _profileOptions("Settings", Icons.settings,context),
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