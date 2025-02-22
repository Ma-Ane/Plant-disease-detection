import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Detector/main.dart';
import 'package:Detector/pages/util/various_assets.dart';
import 'package:Detector/MongoDb/mongo_work.dart';

class Posts extends StatefulWidget{
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts>{

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  File? image;
  bool postReq =false;

  Future<void> _galleryOption() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery) ;
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path) ;
      });
    }
  }

  Future<void> _cameraOption() async{
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> _handlePost(Account a) async{
    try{
      await Post.insertPost(a.accountId, descriptionController.text,titleController.text ,image);
    }catch(e){
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Make a Post")
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
        
            Consumer<OnDeviceStorage>(builder: (context, userFile, _) =>
                TextAndWidget(name: userFile.userAcc.userName, pic: userFile.userAcc.profileImage)),
        
            const SizedBox(height: 20),
        
            Text("Enter a Title for your post: ", style: theme.textTheme.titleMedium),
        
            const SizedBox(height: 20),
        
            DesignedTextController(hintText:  "", controller:  titleController),
        
            const SizedBox(height: 20),
        
            if(image != null) Image.file(image!,width: 300),
        
            const SizedBox(height: 20),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _cameraOption,
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
        
            Text("Enter a description about your post: ", style: theme.textTheme.titleMedium),
        
            const SizedBox(height: 20),
        
            DesignedTextController(hintText: "", controller:  descriptionController),
        
            designedButton(context, "Post", (){
              try{
                _handlePost(Provider.of<OnDeviceStorage>(context).userAcc);
              }catch(e){
                displayError(context, e);
              }
              displayError(context, "Post made!");
        
              setState(() => postReq = true);
        
            }),
        
        
          ]
        ),
      ),
    );
  }
}