

import 'package:Detector/MongoDb/mongo_work.dart';
import 'package:Detector/pages/util/various_assets.dart';
import 'package:flutter/material.dart';

class MakeComment extends StatefulWidget{
  const MakeComment({super.key});

  @override
  State<MakeComment> createState() => _MakeCommentState();
}

class _MakeCommentState extends State<MakeComment>{
  late TextEditingController pdescController;

  void _makeComment() async{
    try{
      final (Post p, Account a) = ModalRoute.of(context)!.settings.arguments as (Post, Account);
      if(a.accountId == null || p.postId == null) throw "Null error";
      Comment.insertComment(a.accountId!, p.postId!, pdescController.text);
    }catch(e){
      displayError(context, e);
    }
  }

  @override
  void initState() {
    super.initState();
    pdescController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make a Comment"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text("Write a comment: "),

            DesignedTextController(hintText: "Comment", controller: pdescController),

            designedButton(context, "Submit", _makeComment),
          ],
        )
      ),
    );

  }
}