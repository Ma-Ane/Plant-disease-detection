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
      ),
      body: Stack(
        children: [
              Container(
                height: double.infinity,
                width: double.infinity,
        
                decoration: const BoxDecoration(
                  // edi color use garne bhaye
                  gradient: LinearGradient(
                    colors:[
                      Color(0xFF17E0BC),
                      Color(0xFF98CE00),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                ),
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
                        ),
                      ),
                    ),
                            
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.05),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[400],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                                  //hoverColor: Colors.red,
                                  onPressed: _addPhoto,
                                  child: image != null ? 
                                    Image.file(image!,
                                      height: 300, 
                                      width: 500, 
                                      fit: BoxFit.cover
                                    ) : 
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.add, size: 50),
                                    ),
                              ),
                      ),
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Text("Post",
                    style: TextStyle(
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
