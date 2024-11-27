import 'package:flutter/material.dart' ;
import 'package:image_picker/image_picker.dart';
import 'dart:io';   // for File datatype

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
    final ImagePicker _picker = ImagePicker();
    File? image ;

  Widget returnUserData(String userName, String userPic) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(userPic, 
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
          ), 
        ),

        const SizedBox(width: 30),

        Text(userName, 
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white
          )
        ),
      ],
    );   
  }

  Future _addPhoto() async {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        backgroundColor: Color(0xff687d91),
      ),
      body: Stack(
        children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color(0xFF344250),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:screenWidth * 0.03, top: screenHeight * 0.02),
                      child: returnUserData("Manjit Maharjan", "images/profile_pic.jpg"),
                    ),
        
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: const TextField(
                        maxLines: null,         // infinite number of lines
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: "Caption the Photo", 
                          hintStyle: TextStyle(color: Color(0xffcfcfcf))
                        ),
                      ),
                    ),
                            
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.05),
                      child:               Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Colors.white,
                ),
                height: 240,
                width: 240,

                // yo chai yedi image xa bhaye image rakhne.. na bhaye ma camera icon
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
                              onPressed: _addPhoto,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            
                              height: 300,
                              minWidth: 500,
                              color: const Color.fromARGB(255, 63, 155, 104),
                              child: const Icon(Icons.add_a_photo_rounded, size: 100),
                            ),
                          // child: Text("Camera Photo",
                          //   style: TextStyle(
                          //     fontSize: 23,
                          //     fontWeight: FontWeight.w400
                          //   )
                          // )
                          ),
              ),
                      // child: Container(
                      //   height: 240,
                      //   width: 240,
                      //   decoration: BoxDecoration(
                      //     color: Color(0xff3f9b68),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: MaterialButton(
                      //             //hoverColor: Colors.red,
                      //             onPressed: _addPhoto,
                      //             child: image != null ? 
                      //               Image.file(image!,
                      //                 height: 240, 
                      //                 width: 240, 
                      //                 fit: BoxFit.cover
                      //               ) : 
                      //               const Align(
                      //                 alignment: Alignment.center,
                      //                 child: Icon(Icons.add, size: 50),
                      //               ),
                      //         ),
                      // ),
                    ),
                  ],
                ),
              ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discard", 
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Text("Post",
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 22, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ) ;
  }
}
