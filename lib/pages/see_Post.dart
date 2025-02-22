
import 'package:Detector/MongoDb/mongo_work.dart';
import 'package:Detector/pages/util/various_assets.dart';
import 'package:flutter/material.dart';

class SeePost extends StatelessWidget{
  
  const SeePost({super.key});
  
  @override
  Widget build(BuildContext context) {
    final (Post p, Account a) = ModalRoute.of(context)!.settings.arguments as (Post, Account);
    return Scaffold(
      appBar: AppBar(
        title: const Text("See Posts"),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            TextAndWidget(
              name: a.userName,
              pic: a.profileImage,
              data: p.ptitle,
            ),
            
            if(p.postImage != null) p.postImage!,
            
            if(p.pdescription != null) Text(p.pdescription!),
            
            const SizedBox(height: 20,)
          ],          
        ),
      )),
    );
    
  }
}