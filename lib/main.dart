import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';
import 'package:my_flutter_app/pages/app_entry.dart';
import 'package:my_flutter_app/pages/posts.dart';
import 'package:my_flutter_app/pages/register.dart';
import 'package:my_flutter_app/pages/search.dart';
import 'package:my_flutter_app/pages/sign_in.dart';
import 'package:my_flutter_app/pages/util/nav.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class OnDeviceStorage extends ChangeNotifier{

  late File file;

  OnDeviceStorage(File x){
    file = x;
  }

  bool get exists => file.existsSync();

  Account get userAcc{
      if(exists){
        if(file.lengthSync() != 0){
          try{
            String data = file.readAsStringSync();
            Account x = accountFromJson(data);
            return x;
          }catch(_){
          }
        }
      }
      return Account();
  }

  set userAcc(Account x){
    String data = accountToJson(x);
    file.writeAsStringSync(data);
    notifyListeners();
  }

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  MongoDatabase.connect();
  Directory applicationFiles = await getApplicationDocumentsDirectory();
  File my = File("${applicationFiles.path}/Account.json");

  runApp(ChangeNotifierProvider(create: (context) => OnDeviceStorage(my),
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Crop Disease Detection',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff354250),
        primaryTextTheme: Typography.blackRedwoodCity,
        textTheme: Typography.whiteRedwoodCity,
        appBarTheme: const AppBarTheme(color:  Color(0xff677d91)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states){
                if(states.contains(WidgetState.pressed)){
                  return const Color.fromARGB(127, 63, 155, 104);
                }
                return const Color.fromARGB(255, 63, 155, 104);
              }),
            foregroundColor: const WidgetStatePropertyAll(Color(0xffffffff)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context)=> const AppEntry(),
        '/sign_in' : (context) => const SignIn(),
        '/register' : (context) => const Register(),
        '/search' : (context) => const Search(),
        '/nav': (context) => const Nav(),
        '/posts': (context) => const Posts(),

      },
    );
  }
}