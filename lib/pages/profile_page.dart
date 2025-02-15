import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/edit.dart';
import 'package:my_flutter_app/pages/help.dart';
import 'package:my_flutter_app/pages/history.dart';
import 'package:my_flutter_app/pages/settings.dart';
import 'package:my_flutter_app/pages/contact_us.dart';

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
        // according to button pressed
        onTap: () => {
          if (name == 'Edit') {Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/edit"),builder: (context) => const Edit()))},
          if (name == 'Help') {Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/help"),builder: (context) => const Help()))},
          if (name == 'History') {Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/history"),builder: (context) => const History()))},
          if (name == 'Contact Us') {Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/contact_us"),builder: (context) => const ContactUs()))},
          if (name == 'Settings') {Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/settings"),builder: (context) => const Settings()))},
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 63, 155, 104),
          ),      
          height: screenHeight * 0.06,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.025),
        
              Icon(icon, size: screenHeight * 0.04,),
        
              SizedBox(width: screenWidth * 0.025),
        
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
    //
    // Image userPic = Image(image: Account.userAcc.pfp !=null?
    //   FileImage(Account.userAcc.pfp!):
    //   const AssetImage("images/blankPfp.jpg")
    // );
    //
    // String userName = "${Account.userAcc.firstname} ${Account.userAcc.middlename} ${Account.userAcc.lastname}";

        // determine the screen height and width
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 66, 80),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 52, 66, 80),
              height: screenHeight * 0.25,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.03),
        
                    // ClipOval(
                    //   child: FittedBox(
                    //     fit: BoxFit.cover,
                    //     child: SizedBox(
                    //       height: screenWidth * 0.25,
                    //       width: screenWidth * 0.25,
                    //       child: userPic,
                    //     ),
                    //   ),
                    // ),
                
                    SizedBox(height: screenHeight * 0.02),
                    //
                    // Text(userName,
                    //     style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 28,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                  ],
                ),
              ),
            ), 
        
            Padding(
              padding: EdgeInsets.only(top:screenHeight * 0.025, left: 10, right:10),
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
          ],
        ),
      ),
    );
  }
}