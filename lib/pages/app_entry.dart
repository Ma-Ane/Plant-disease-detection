import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';
import 'package:my_flutter_app/main.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  late Future<Account?> onDevAcc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Disease Detection",style: theme.textTheme.titleLarge),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset('images/logo.jpg'),

          const SizedBox(height: 50),

          // sign in button
          Align(
            alignment: Alignment.center,
            child:
             designedButton(context, "Sign In", () {
                  if(Provider.of<OnDeviceStorage>(context).exists){
                    if(! Provider.of<OnDeviceStorage>(context).userAcc.isnull){
                      Navigator.pushNamed(context, '/nav');
                    }
                  }
                  Navigator.pushNamed(context, '/sign_in');
                }
              )
          ),

          // register button
          designedButton(context, "Register", () {
              Navigator.pushNamed(context, '/register');
            }
          ),

          designedButton(context, "Offline", () {
              Navigator.pushNamed(context, '/search');
            }
          ),
        ],
      )
    );
  }
}