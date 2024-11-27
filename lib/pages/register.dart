import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/main_page.dart';
import 'package:my_flutter_app/pages/util/my_button.dart';
// import 'package:plant_disease/pages/util/my_button.dart';
// import 'package:plant_disease/pages/main_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String? _selectedGender; // Variable to store selected gender

  
  int sum = 0 ;
  final RegExp _nameRegExp = RegExp(r'^[A-Za-z]+$');
  final RegExp _emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp _passwordRegExp = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]+$');

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  // custom function for each input field
  Widget customInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    IconData? icon,
    bool isPassword = false,
  }) {
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
              hintStyle: TextStyle(color: Colors.black26),
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
    if (!_nameRegExp.hasMatch(firstNameController.text)) {      
      return 1 ;
    }
    if (!_nameRegExp.hasMatch(middleNameController.text) &&  middleNameController.text != "" ) {      
      return 2; 
    }
    if (!_nameRegExp.hasMatch(lastNameController.text)) {      
      return 3; 
    }
    if (!_emailRegExp.hasMatch(emailController.text)) {
      return 4 ;
    }
    if(!_passwordRegExp.hasMatch(passwordController.text)) {
      return 5 ;
    }
    
    return 0 ;
    //sum = check.reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Register"),
      //   backgroundColor: const Color.fromARGB(255, 135, 203, 140),
      // ),
      body: Container(
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
                  //color: Color.fromARGB(255, 175, 76, 69),
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                )
              ),
        
              const SizedBox(height: 60),
        
              Container(
                height: 550, 
                width: double.infinity,
                //color: Colors.yellow,
                
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0, right: 10),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customInputField(
                        label:"First Name",
                        
                        hintText: "KP",
                        controller: firstNameController
                      ),
                  
                      const SizedBox(height: 10),
                  
                      customInputField(label: "Middle Name (Optional)", hintText: "Sharma", controller: middleNameController),
                  
                      const SizedBox(height: 10),
                  
                      customInputField(label: "Last Name", hintText: "Oli", controller: lastNameController), 
                  
                      const SizedBox(height: 10),
                  
                      Column(
                        children: [
                          // const Text("Gender: ",
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //   )
                          // ),
        
                          DropdownButtonFormField(
                            dropdownColor: const Color.fromARGB(255, 173, 204, 217),
                            value: _selectedGender,
                            hint: const Text('Choose your gender', 
                              style: TextStyle(
                                color: Color.fromARGB(255, 173, 204, 217),
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            items: ['Male', 'Female', 'Others']
                                .map((String gender) {
                                  return DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender, style: const TextStyle(color: Color.fromARGB(255, 173, 204, 217))),
                                  );
                                })
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            ),
                          ),
                        ]
                      ),
        
                      const SizedBox(height: 10),
                  
                      customInputField(label: "Email", hintText: "k.p.oli@gmail.com", controller: emailController),
                
                      const SizedBox(height: 10),
                  
                      customInputField(label: "Password", hintText: "********", controller: passwordController, isPassword: true),
                    ],
                  ),
                ),
              ),
        
              MyButton(
                text: "Register", 
                onPressed: () {
                  int sum = _checkValidity() ;
                  switch (sum) {
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage())) ;
                      break ;
                    
                    default:
                      String name = "Name" ;
                      String other = "Name must contain only alphabet letters." ;
        
                      if (sum == 4) {name = "Email"; other = "Email is not in right format.";}
                      if (sum == 5) {name = "Password"; other = "Password is not in right format.";}
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Invalid $name"),
                            content: Text(other),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                  }
                }
              ),
            ],
            ),
      )
    );
  }
}