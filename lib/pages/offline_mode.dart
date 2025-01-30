import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/TFlite/tf_work.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';

class OfflineMode extends StatefulWidget{
  const OfflineMode({super.key});

  @override
  State<OfflineMode> createState() => _OfflineMode();
}

class _OfflineMode extends State<OfflineMode> with TickerProviderStateMixin{
  File? image;
  final ImagePicker _picker = ImagePicker();
  final Color primaryColor = const Color(0xFFA6BC36); 
  final Color secondaryColor = const Color(0xFF3498DB);
  final Color thirdColor = const Color(0xFFAFD06E);

  Future _galleryOption() async {
     final pickedFile = await _picker.pickImage(source: ImageSource.gallery) ;

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path) ;
      });
    }
  }

  Future handleSearch(BuildContext context) async{
    int detectedDiseaseNo;      
    try{
      const CircularProgressIndicator();
      detectedDiseaseNo = await TfWork.getPredictions(image!, 300, 36, "efficientNetB3");
      if(context.mounted){
        VariousAssets.displayError(context, "Disease detected!", details: detectedDiseaseNo);
      }
      
    }catch(e){
      if(context.mounted){
        VariousAssets.displayError(context, "Disease detection error",details: e);
      }
    }
  }

  @override
  Widget build(BuildContext context){
  double screenHeight = MediaQuery.of(context).size.height ;
  double screenWidth = MediaQuery.of(context).size.width ;

  return Scaffold(
    backgroundColor: const Color(0xFF344250),
      appBar: AppBar(
        backgroundColor: const Color(0xff687d91),
        title: const Text("Detection Page"),
        elevation: 0,
      ),
    body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top:screenHeight * 0.1, left: screenWidth * 0.05, right: screenWidth * 0.05),
    
            child: const Text("Upload Picture for Disease Detection",
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w700,
              )
            ),
          ),
      
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.05, right: screenWidth * 0.05),
    
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 240,
                  width: 240,
    
                  child: image != null ? 
    
                          // image ko property
                          Image.file(image!,
                            height: 240, 
                            width: 240, 
                            fit: BoxFit.cover) : 
    
                          // camera button lai milako
                          Align(
                            alignment: Alignment.center,
                              child: MaterialButton(
                                onPressed: _galleryOption,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              
                                height: 300,
                                minWidth: 500,
                                color: const Color.fromARGB(255, 63, 155, 104),
                                child: const Icon(Icons.photo_camera, size: 100),
                              ),
                            ),
                ),
              ],
            ),
          ),
      
          const SizedBox(height: 40),
      
          Align(
            alignment: Alignment.center,
    
            child: VariousAssets.myButton("Detect",
              (){image == null ? 
                VariousAssets.displayError(context, "Please select an image first") :
                handleSearch(context);
              }
              ), 
          ),
        ],
      ),
  );
  }

}