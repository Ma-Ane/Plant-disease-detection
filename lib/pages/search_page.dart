import 'dart:io';   // for File datatype
import 'package:flutter/material.dart' ;
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/pages/after_detection.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Color primaryColor = const Color(0xFFA6BC36); 
  final Color secondaryColor = const Color(0xFF3498DB);
  final Color thirdColor = const Color(0xFFAFD06E); 

    final ImagePicker _picker = ImagePicker();
    File? image ;

  Future _galleryOption() async {
     final pickedFile = await _picker.pickImage(source: ImageSource.gallery) ;

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path) ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top:screenHeight * 0.1, left: screenWidth * 0.05, right: screenWidth * 0.05),
          child: const Text("Upload Picture for Disease Detection.",
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w700,
            )
          ),
        ),
    
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.05, right: screenWidth * 0.05),
          child: Stack(
            children: [
              // yo sayaddd container chaidaina holaa 
            
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen[400],
                ),
                height: 300,
                width: 500,
                child: image != null ? 
                        Image.file(image!,
                          height: 300, 
                          width: 500, 
                          fit: BoxFit.cover) : 
                        Align(
                          alignment: Alignment.center,
                            child: MaterialButton(
                              onPressed: _galleryOption,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            
                              height: 300,
                              minWidth: 500,
                              color: thirdColor,
                              child: const Icon(Icons.photo_camera, size: 100),
                            ),
                          // child: Text("Camera Photo",
                          //   style: TextStyle(
                          //     fontSize: 23,
                          //     fontWeight: FontWeight.w400
                          //   )
                          // )
                          ),
              ),
            ],
          ),
        ),
    
        const SizedBox(height: 40),
    
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Padding(
        //       padding: EdgeInsets.only(right: screenWidth * 0.15),
        //       child: MaterialButton(
        //         onPressed: _galleryOption,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(20),
        //         ),
              
        //         height: 50,
        //         minWidth: 50,
        //         color: const Color.fromARGB(255, 226, 210, 246),
        //         child: const Icon(Icons.photo_camera),
        //       ),
        //     ),
        // ),

        Align(
          alignment: Alignment.center,
          child: MaterialButton(
            onPressed: () {
              image == null ?
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Please choose a photo first.",
                        style: TextStyle(
                          fontSize: 20,
                        )
                      ),
                      actions:[
                        TextButton(onPressed: () { 
                          Navigator.of(context).pop() ;
                        }, 
                        child: const Text("OK"))
                      ],
                    ) ;
                  }
                ) :
                Navigator.push(context, MaterialPageRoute(builder: (context) => AfterDetection(image: image))) ;
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            height: screenHeight * 0.05,
            minWidth: screenWidth * 0.1,
            color: const Color.fromARGB(255, 226, 210, 246),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Detect",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                )
              ),
            ),
          )
        ),
      ],
    );
  }
}