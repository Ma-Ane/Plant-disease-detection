import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class VariousAssets {

  static Future displayError(BuildContext context, Object e, {Object? details}){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(e.toString(),
            style: const TextStyle(
              fontSize: 20,
            )
          ),
          actions:[
            TextButton(
              onPressed: () {Navigator.of(context).pop() ;}, 
              child: const Text("OK")
            )
          ],
          content: details==null?
            (null):
            (Text(details.toString(),
            style: const TextStyle(
              fontSize: 16
            ),
          )),
        );
      }
    ); 
  }

  static Future<File> loadFile(String path) async{
    final temp = await rootBundle.load(path);
    final String tempDir = Directory.systemTemp.path;
    final File tempFile = File('$tempDir/${mongo.ObjectId()}');
    await tempFile.writeAsBytes(temp.buffer.asUint8List());
    return tempFile;
  }

  static Widget myButton(String text, VoidCallback onPressed){
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top:20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        color: const Color(0xFFB4d3b2),
        height: 45,
        minWidth: 120,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        ),
    );
  }

}