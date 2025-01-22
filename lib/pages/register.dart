import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
import 'package:my_flutter_app/MongoManagement/mongomgmt.dart';
import 'package:my_flutter_app/pages/main_page.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  int sum = 0 ;
  //final RegExp _nameRegExp = RegExp(r'^[a-zA-Z]$');
  //final RegExp _emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  //final RegExp _passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$');

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  // custom function for each input field
  Widget customInputField(
    {
      required String label,
      required String hintText,
      required TextEditingController controller,
      IconData? icon,
      bool isPassword = false,
    }
  )  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:5.0),
          child: Text(label,
            style: const TextStyle(
              color: Color.fromARGB(255, 173, 204, 217),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          ),
        ),

        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.only(left: 15, right: 90),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              //label: Text(label),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black26),
              border: InputBorder.none,
              icon: icon != null ? Icon(icon) : null,
            ),
          ),
        ),
      ],
    );
  }

  int _checkValidity () {
    //int check = -1 ;    // each value for each input field
    //if (!_nameRegExp.hasMatch(firstNameController.text)) {
    //  return 1 ;
   // }
    //if (!_nameRegExp.hasMatch(middleNameController.text) &&  middleNameController.text != "" ) {
      //return 2;
    //}
    //if (!_nameRegExp.hasMatch(lastNameController.text)) {
    //  return 3;
    //}
   // if (!_emailRegExp.hasMatch(emailController.text)) {
    //  return 4 ;
    //}
    //if(!_passwordRegExp.hasMatch(passwordController.text)) {
     // return 5 ;
    //}
    
    return 0 ;
    //sum = check.reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 66, 80),
      // appBar: AppBar(
      //   title: const Text("Register"),
      //   backgroundColor: const Color.fromARGB(255, 135, 203, 140),
      // ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            // edi color use garne bhaye
            color: Color.fromARGB(255, 52, 66, 80)
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top:80.0),
                child: Text("Registration Page",
                  style: TextStyle(
                    color: Color.fromARGB(255, 173, 204, 217),
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
        
              const SizedBox(height: 50),
          
              const Text("Please provide the following information.",
                style: TextStyle(
                  color: Color.fromARGB(255, 173, 204, 217),
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                )
              ),
          
              const SizedBox(height: 60),
          
              SizedBox(
                height: 550, 
                width: double.infinity,
                                    
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0, right: 10),
                  child: Column(
                     
                    children: [
                      customInputField(
                        label:"First Name",
                          
                        hintText: "John",
                        controller: firstNameController
                      ),
                    
                      const SizedBox(height: 10),
                    
                      customInputField(label: "Middle Name (Optional)", hintText: "Deer", controller: middleNameController),
                    
                      const SizedBox(height: 10),
                    
                      customInputField(label: "Last Name", hintText: "Doe", controller: lastNameController), 
                    
                      const SizedBox(height: 10),                    
          
                      const SizedBox(height: 10),
                    
                      customInputField(label: "Email", hintText: "abc@example.com", controller: emailController),
                  
                      const SizedBox(height: 10),
                    
                      customInputField(label: "Password", hintText: "*****", controller: passwordController, isPassword: true),
                    ],
                  ),
                ),
              ),
          
              VariousAssets.myButton(
                "Register", 
                () async{
                  if(MongoDatabase.isconnected == false || MongoDatabase.dbError != null){
                    if(context.mounted){
                      VariousAssets.displayError(context, "Connection Error", details: MongoDatabase.dbError);
                    }
                  }
                  else{
                    int sum = _checkValidity() ;
                    switch (sum) {
                      case 0:
                      try{
                        await Account.insertAcconut(firstNameController.text, middleNameController.text, lastNameController.text, emailController.text, passwordController.text,null);
                        Account.userAcc = await Account.retreiveAcconutep(emailController.text,passwordController.text);
                      
                        if(context.mounted&&Account.userAcc.isnull==false){
                          Navigator.of(context).push(MaterialPageRoute(settings: const RouteSettings(name: "/main_page"),builder: (context)=>const MainPage()));
                        }
                        else if(context.mounted){
                          VariousAssets.displayError(context, "Connection error!", details: "Cannot confirm creation of account");
                        }
                      }catch(e){
                        if(context.mounted){
                          VariousAssets.displayError(context, "Connection error!",details: e);
                        }
                      }
                      
                      break ;
                      
                      default:
                        String name = "Name" ;
                        String other = "Name must contain only alphabet letters." ;
          
                        if (sum == 4) {name = "Email"; other = "Email is not in right format.";}
                        if (sum == 5) {name = "Password"; other = "Password is not in right format.";}
                        
                        VariousAssets.displayError(context, "Invalid $name", details: other);
                    }
                  }
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}