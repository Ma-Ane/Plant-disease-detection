import 'package:flutter/material.dart' ;

// privacy bhanne euta chuttai page jasto
class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Widget returnSetting (BuildContext context, String name) {
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Padding(
      padding: EdgeInsets.only(left:screenWidth*0.04, right:screenWidth*0.02, top: screenHeight*0.02),
      child: Row(
        children: [
          const Icon(Icons.privacy_tip_outlined, color: Colors.white,),
      
          SizedBox(width: screenWidth* 0.05),
      
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    ) ;
  }

  Widget displayContent (String? value) {
    
    if (value == 'Privacy') {

    } 
    
    return Column(
      children: [
        GestureDetector(
          onTap:() => {const Privacy()},
          child: returnSetting(context, 'Privacy'),
        ),
      ],
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    // kun pgae ko lagi
    String? value = '' ;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 66, 80),
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: SingleChildScrollView(
        child: displayContent(value),
      ),
    );
  }
}