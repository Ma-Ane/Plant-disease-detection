import 'package:flutter/material.dart';
import 'package:my_flutter_app/main.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{

  Widget _makePost(){
    return Container(
      decoration: const BoxDecoration(
          color: Color(0x44ffffff),
          shape: BoxShape.circle
      ),
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/posts');
          },
          child: const Icon(Icons.add, size: 50,)
      ),
    );
  }

  Future<List<Widget>> _getPosts() async{
    List<Widget> foo = [];

    try{
      
    }catch(e){
      rethrow;
    }

    return foo;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
        
            Consumer<OnDeviceStorage>(builder: (context, userFile, _) =>
              homeWidgets(context: context, name: userFile.userAcc.userName, pic: userFile.userAcc.profileImage, data: "Make a Post", extra: _makePost())
            ),

            const SizedBox(height: 20),


          ],
        ),
      )
    );
  }

}