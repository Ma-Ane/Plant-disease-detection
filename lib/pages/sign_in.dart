import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
import 'package:my_flutter_app/MongoManagement/mongomgmt.dart';
import 'package:my_flutter_app/pages/main_page.dart';
import 'package:my_flutter_app/pages/register.dart';
import 'package:my_flutter_app/pages/util/various_assets.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  
  final TextEditingController gmailControllerSignIn = TextEditingController();
  final TextEditingController passwordControllerSignIn = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 66, 80),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Sign In",
         style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 52, 66, 80),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
          ),

          child: Padding(
            padding: const EdgeInsets.only(left:15.0, right: 15, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Email",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )      
                ),

                TextField(
                  controller: gmailControllerSignIn,
                  decoration: const InputDecoration(
                    hintText: "abc@gmail.com",
                    hintStyle: TextStyle(color: Colors.black26)
                  ),
                ),

                const SizedBox(height: 30),

                const Text("Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )      
                ),

                TextField(
                  controller: passwordControllerSignIn,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.visibility_off),
                    hintText: "123Abc@",
                    hintStyle: TextStyle(color: Colors.black26)
                  )
                ),

                const SizedBox(height: 40),

                GestureDetector(
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                  ),
                  onTap: () {
                    VariousAssets.displayError(context,"Contact the administrators");
                 },
                ),

                const SizedBox(height: 50),

                Center(
                  child: VariousAssets.myButton(
                    "Sign In", 
                    () async{
                      if(MongoDatabase.isconnected == false || MongoDatabase.dbError != null){
                        if(context.mounted){
                          VariousAssets.displayError(context, "Connection Error", details: MongoDatabase.dbError);
                        }
                      }
                      else{
                        try{
                          Account.userAcc = await Account.retreiveAcconutep(gmailControllerSignIn.text,passwordControllerSignIn.text);
                          }catch(e){
                            if(context.mounted){
                              VariousAssets.displayError(context,e);
                            }
                          }
                        if(context.mounted){
                          if((Account.userAcc.isnull==true)){
                            VariousAssets.displayError(context,"Could not retrieve the specified account!");
                          }
                          else{
                            Navigator.of(context).push(MaterialPageRoute(settings: const RouteSettings(name: "/main_page"),builder: (context)=>const MainPage()));
                          }
                        }
                      }
                    }
                  ),
                ),

                const SizedBox(height: 100),

                Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Don't have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          )
                        ),
                    
                        const SizedBox(height: 20),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/register"),builder: (context) => const Register()));
                          },
                          child: const Text("Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 23,
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ) 
    );
  }
}