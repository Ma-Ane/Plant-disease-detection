
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/main.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';
import 'package:my_flutter_app/MongoDb/mongo_work.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>{

  File? image;
  bool regReq = false;

  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  Future<Account> _handleRegister()async{
    if(MongoDatabase.isConnected == false) {
      throw "Could not connect to database.";
    }
    else if(MongoDatabase.dbError != null){
      throw MongoDatabase.dbError!;
    }
    try{
      Account userAcc = await Account.retreiveAccountep(emailController.text,passwordController.text);
      if(userAcc.isnull){
        await Account.insertAccount(firstNameController.text, middleNameController.text, lastNameController.text, emailController.text, passwordController.text, image);
        userAcc = await Account.retreiveAccountep(emailController.text,passwordController.text);

        if(!userAcc.isnull){
          return userAcc;
        }
        else{
          throw "Could not verify insertion of details.";
        }

      }
      else{
        throw "This Account Already exists";
      }
    }catch(e){
      rethrow;
    }
  }

  Future<void> _galleryOption() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery) ;
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
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

  @override
  void initState(){
    super.initState();
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            Text("  First Name (Optional)", style: theme.textTheme.titleLarge),

            designedTextController(context, "First Name", "John", firstNameController),

            const SizedBox(height: 20),

            Text("  Middle Name (Optional)", style: theme.textTheme.titleLarge),

            designedTextController(context, "Middle Name", "", middleNameController),

            const SizedBox(height: 20),

            Text("  Last Name (Optional)", style: theme.textTheme.titleLarge),

            designedTextController(context, "Last Name", "Doe", lastNameController),

            const SizedBox(height: 20),

            Text("  Email", style: theme.textTheme.titleLarge),

            designedTextController(context, "Email", "example@123.com", emailController),

            const SizedBox(height: 20),

            Text("  Password", style: theme.textTheme.titleLarge),

            designedTextController(context, "Password", "****", passwordController, true),

            const SizedBox(height: 40),

            Text("  Choose a profile picture (Optional)", style: theme.textTheme.titleLarge),

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
                  child: const Icon(Icons.image, size: 100),
                ),
              ],
            ),

            //if button below is pressed to register: display progress indicator while processing, go to Home page when completed, and display an error message if encountered
            if (regReq) FutureBuilder(future: _handleRegister(), builder: (BuildContext context, AsyncSnapshot<Account> snapshot ){
              Widget child = const SizedBox();
              if(snapshot.hasData){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<OnDeviceStorage>(context).userAcc = snapshot.data!;
                  Navigator.of(context).pushReplacementNamed('/nav', arguments: snapshot.data);
                  setState(() => regReq = false);
                });
              }
              else if(snapshot.hasError){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  displayError(context, snapshot.error!);
                  setState(() {
                    regReq = false;
                  });
                });
              }
              else{
                child = const CircularProgressIndicator();
              }
              return child;
            }),

            Align(
              child: designedButton(context, "Register",(){
                setState(() => regReq = true);
                _handleRegister();
              }),
            ),

            const SizedBox(width: 40),

          ],
        ),
      ),
    );
  }
}