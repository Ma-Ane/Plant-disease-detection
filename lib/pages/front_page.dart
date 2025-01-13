import 'dart:io';

import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/MongoManagement/mongomgmt.dart';
import 'package:my_flutter_app/pages/register.dart';
import 'package:my_flutter_app/pages/sign_in.dart';
import 'package:my_flutter_app/pages/util/my_button.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  Future<void> checkdb(BuildContext context) async{
    try{
      bool x = await MongoDatabase.connect();
      if(x==false){
        if(context.mounted){
         showDialog(
           context: context, 
           builder: (BuildContext context) {
             return AlertDialog(
              title: const Text("Connection error!"),
              content: const Text("Could not connect to servers."),
              actions: [
                TextButton(
                  onPressed: () =>exit(0), 
                  child: const Text("Ok"),
                )
              ]
             );
            }   
          );
        }
     }
    }catch(e){      
      if(context.mounted){
        showDialog(        
          context: context, 
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Connection error!"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () =>exit(0), 
                  child: const Text("Ok"),
                )
              ]
            ) ;
          }   
        );
      }
    }
  }
    

  @override
  Widget build(BuildContext context) {

    checkdb(context);

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
            child: MyButton(text: "Sign In", onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn()));
              }
            )
          ),

          // register button
          MyButton(text: "Register", onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const Register()));
            }
          ),
        ],
      )
    );
  }
}