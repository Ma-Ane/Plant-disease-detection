import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';
import 'package:my_flutter_app/TFlite/tf_work.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';

class Search extends StatefulWidget{
  const Search({super.key});

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> with TickerProviderStateMixin<Search>{

  File? image;
  bool detectRequested = false;

  Map<int, String> diseaseNameMap = {
    0: 'Healthy Apple',
    1: 'Rotten Apple',
    2: 'Apple with Rust',
    3: 'Apple with Scab',
    4: 'Healthy Corn',
    5: 'Corn Leaf with Blight',
    6: 'Corn Leaf with Gray Spot',
    7: 'Corn Leaf with Green Spot',
    8: 'Corn Leaf with Rust',
    9: 'Healthy Coffee',
    10: 'Coffee with Rust',
    11: 'Pepperbell with bacterial Spot',
    12: 'Healthy Pepperbell',
    13: 'Potato with Early Blight',
    14: 'Healthy Potato',
    15: 'Potato with Late Blight',
    16: 'Healthy Rice',
    17: 'Rice Leaf with Blast',
    18: 'Rice Leaf with Blight',
    19: 'Rice Leaf with Brown Spot',
    20: 'Rice Leaf Smut',
    21: 'Rick Neck Blast',
    22: 'Healthy Strawberry',
    23: 'Scorched Strawberry Leaf',
    24: 'Tea Algal Sot',
    25: 'Tea with Brown Blight',
    26: 'Healthy Tea',
    27: 'Tea with Red Leaf Spot',
    28: 'Tomato with Bacterial Spot',
    29: 'Tomato with Early Blight',
    30: 'Healthy Tomato',
    31: 'Tomato with Late Blight',
    32: 'Tomato with Leaf Mold',
    33: 'Tomato with Mosiac Virus',
    34: 'Tomato with Septoria Leaf Spot',
    35: 'Tomato with Target Spot'
  };

  Future<void> _galleryOption() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery) ;
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path) ;
        detectRequested = false;
      });
    }
  }

  Future<void> _cameraOption() async{
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.path);
        detectRequested = false;
      });
    }
  }

  Future<Disease> _handleSearch() async{
    Disease detectedDisease = Disease();
    try{
      int index = await TfWork.getPredictions(image!, 300, 36, "efficientNetB3");
      if(MongoDatabase.dbError != null && MongoDatabase.isConnected){
        detectedDisease = await Disease.retreiveDisease(index);
      }
      if(detectedDisease.isnull){
        return Disease(dname: diseaseNameMap[index], jsonId: index, isnull: false);
      }
      return detectedDisease;
    }catch(e){
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context){
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detection Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if(detectRequested) FutureBuilder<Disease>(future: _handleSearch(), builder: (BuildContext context, AsyncSnapshot<Disease> snapshot){
              List<Widget> snapshotWidgets =[];
              if(snapshot.hasData){
                if(snapshot.data != null) {
                  snapshotWidgets.add(Image.file(image!,height: 300, fit: BoxFit.fitHeight,));
                  snapshotWidgets.add(const SizedBox(height: 20));
                  snapshotWidgets.add(Text(
                      "Possible Detection Found", style: theme.textTheme.labelLarge));
                  snapshotWidgets.add(Text(snapshot.data!.dname??"",
                      style: theme.textTheme.bodyMedium));
                }
                else{
                  snapshotWidgets.add(Image.file(image!,width: 300));
                  snapshotWidgets.add(Text("Detection Error", style: theme.textTheme.labelLarge));
                  snapshotWidgets.add(Text(
                      "Please contact the developers. This should not have happened", style: theme.textTheme.bodyMedium));
                }
              }
              else if(snapshot.hasError){
                snapshotWidgets.add(Image.file(image!,width: 300));
                snapshotWidgets.add(Text(
                    "Detection Error", style: theme.textTheme.labelLarge));
                snapshotWidgets.add(Text(snapshot.error.toString(),
                    style: theme.textTheme.bodyMedium));
              }
              else{
                snapshotWidgets.add(const CircularProgressIndicator());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: snapshotWidgets,
              );
            })

            else if (image != null) Image.file(image!,width: 300),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _cameraOption,
                  //color: const Color.fromARGB(255, 63, 155, 104),
                  child: const Icon(Icons.camera_alt, size: 100),
                ),

                const SizedBox(width: 40),

                ElevatedButton(
                  onPressed: _galleryOption,
                  //color: const Color.fromARGB(255, 63, 155, 104),
                  child: const Icon(Icons.image, size: 100),
                ),
              ],
            ),

            const SizedBox(height: 20),

            designedButton(context, "Detect", (){setState(() {
              detectRequested = true;
            }); _handleSearch();}),

          ],
        ),
      ),
    );
  }
}