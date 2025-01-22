import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/register.dart';
import 'package:my_flutter_app/pages/sign_in.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
    

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: const Color(0xFF344250),
      appBar: AppBar(
        backgroundColor: const Color(0xff687d91),
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
            child:
             VariousAssets.myButton(
                "Sign In", 
                () {
                  Navigator.push(context,MaterialPageRoute(settings: const RouteSettings(name: "/sign_in"),builder: (context) => SignIn()));
                }
              )
          ),

          // register button
          VariousAssets.myButton("Register", () {
              Navigator.push(context,MaterialPageRoute(settings: const RouteSettings(name: "/register"),builder: (context) => const Register()));
            }
          ),
        ],
      )
    );
  }
}