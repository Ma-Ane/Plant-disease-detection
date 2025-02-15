import 'package:flutter/material.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';
import 'package:my_flutter_app/main.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Consumer<OnDeviceStorage>(builder: (context, userFile, _) => widgetNamePic(context, userFile.userAcc)),

          const SizedBox(height: 20),

          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/posts');
              },
              child: const Icon(Icons.add)
            ),
          ),
        ],
      )
    );
  }

}