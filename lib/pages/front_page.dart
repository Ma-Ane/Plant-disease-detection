import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/register.dart';
import 'package:my_flutter_app/pages/sign_in.dart';
import 'package:my_flutter_app/pages/util/my_button.dart';
// import 'package:plant_disease/pages/register.dart';
// import 'package:plant_disease/pages/sign_in.dart';
// import 'package:plant_disease/pages/util/my_button.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  void signIn () {
    // Navigate to the SignIn page when button is pressed
    Navigator.push(
      context,
        MaterialPageRoute(builder: (context) => SignIn()),
     );
  }

   void register() {
    // navigate to the Register page when button is pressed
    Navigator.push(
      context,
        MaterialPageRoute(builder: (context) => const Register()),
     );
  }

  @override
  Widget build(BuildContext context) {

    // determine the screen height and width
    //double screenHeight = MediaQuery.of(context).size.height ;
    //double screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      backgroundColor: const Color(0xFFFCEFEF),
      appBar: AppBar(
        title: const Text("Crop Disease Detection"),
        elevation: 0,
      ),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/logo.jpg'),

          const SizedBox(height: 70),

          // sign in button
          Align(
            alignment: Alignment.center,
            child: MyButton(text: "Sign In", onPressed: signIn)),

          // register button
          MyButton(text: "Register", onPressed: register),
        ],)
    );
  }
}