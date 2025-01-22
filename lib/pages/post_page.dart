import 'package:flutter/material.dart' ;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
    final ImagePicker _picker = ImagePicker();
    File? image ;

  Widget returnUserData(String userName, Image userPic) {
    return Row(
      children: [
        ClipOval(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(                    
              height: 50,
              width: 50,
              child: userPic, 
            ),
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

  Future handleSubmit(String desctxt, String titletxt, File? img) async{
    try{
      Post.insertPost(Account.userAcc.aid, desctxt, titletxt, img);
      
      if(context.mounted){
        VariousAssets.displayError(context, "Your post has been made");
      } 
      
      Navigator.of(context).popUntil(ModalRoute.withName("/home_page"));
    }catch(e){
      if(context.mounted){
        VariousAssets.displayError(context, "Connection Error",details: e);
      }
    }
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

    Image userPic = Image(image: Account.userAcc.pfp !=null?
      FileImage(Account.userAcc.pfp!):
      const AssetImage("images/blankPfp.jpg")
    );
    
    String userName = "${Account.userAcc.firstname} ${Account.userAcc.middlename} ${Account.userAcc.lastname}";
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController descriptioncontroller = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        backgroundColor: const Color(0xff687d91),
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
                child: returnUserData(userName, userPic),
              ),
        
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Container(
                  constraints: BoxConstraints(maxHeight: screenHeight*0.1),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 53, 66, 80),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color.fromARGB(255, 103, 125, 145)),
                  ),
                  child: TextField(
                    maxLines: null,         // infinite number of lines
                    minLines: 1,
                    controller: titlecontroller,
                    decoration: const InputDecoration(
                      hintText: "Write a Caption",
                      hintStyle: TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(
                        color: Colors.white
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
                            
              Padding(
                padding: EdgeInsets.all(screenHeight * 0.05),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                  height: screenHeight * 0.2,
                  width: screenHeight * 0.2,
                  // yo chai yedi image xa bhaye image rakhne.. na bhaye ma camera icon
                  child: image != null ? Image.file(image!,fit: BoxFit.cover) : Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      onPressed: _addPhoto,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                      height: 300,
                      minWidth: 500,
                      color: const Color.fromARGB(255, 63, 155, 104),
                      child: const Icon(Icons.add_a_photo_rounded, size: 100),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Container(
                  constraints: BoxConstraints(maxHeight: screenHeight * 0.2),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    maxLines: null,         // infinite number of lines
                    minLines: 1,
                    controller: descriptioncontroller ,
                    decoration: const InputDecoration(
                      hintText: "Write a description",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VariousAssets.myButton("Discard",
                    (){Navigator.of(context).pop();}
                  ),
                  
                  VariousAssets.myButton("Submit",
                    (){handleSubmit(descriptioncontroller.text, titlecontroller.text, image);}
                  ),
                ],
              ),
            ],
          ),
        ),
      
        ],
      ),
    ) ;
  }
}
