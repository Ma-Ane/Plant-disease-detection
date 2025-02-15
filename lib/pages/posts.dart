import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/main.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';
import 'package:provider/provider.dart';

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

  Future<bool> _handlePost(Account a) async{
    try{
      await Post.insertPost(a.accountId, descriptionController.text,titleController.text ,image);
      return true;
    }catch(e){
      rethrow;
    }
  }

  Widget _widgetNamePic(Account a, TextStyle style) {
    return Row(
      children: [
        ClipOval(child: a.profileImage),

        const SizedBox(width: 15),

        Text(a.userName, style: style),
      ],
    );
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
        title: const Text("Post")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Consumer<OnDeviceStorage>(builder: (context, userFile, _) => widgetNamePic(context, userFile.userAcc)),

          const SizedBox(height: 20),

          Text("Enter a Title for your post: ", style: theme.textTheme.labelLarge),

          const SizedBox(height: 20),

          designedTextController(context, "Title", "", titleController),

          const SizedBox(height: 20),

          if(image != null) Image.file(image!,width: 300),

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

          Text("Enter a description about your post: ", style: theme.textTheme.labelLarge),

          const SizedBox(height: 20),

          designedTextController(context, "description", "", descriptionController),

          designedButton(context, "Post", (){
            _handlePost(Provider.of<OnDeviceStorage>(context).userAcc);
            setState(() => postReq = true);
          }),

          if(postReq) FutureBuilder(future: _handlePost(Provider.of<OnDeviceStorage>(context).userAcc), builder: (BuildContext context, AsyncSnapshot<void> snapshot){
            Widget child = const SizedBox();
            if(snapshot.hasData){
              WidgetsBinding.instance.addPostFrameCallback((_){
                displayError(context, "Post made successfully");
                setState(() => postReq = false);
              });
            }
            else if(snapshot.hasError){
              WidgetsBinding.instance.addPostFrameCallback((_){
                displayError(context, "Posting Error", snapshot.error);
                setState(() => postReq = false);
              });
            }
            else{
              child = const CircularProgressIndicator();
            }
            return child;
          })

        ]
      ),
    );
  }
}