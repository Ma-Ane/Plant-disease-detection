import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
class AfterDetection extends StatelessWidget {
  final Disease detectedDisease;
  const AfterDetection(this.detectedDisease,{super.key,});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      appBar: AppBar(title: const Text("Detection Diseases")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            SizedBox(height: screenHeight * 0.02),
 
        ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: detectedDisease.dimg!=null?
                Image.file(detectedDisease.dimg!,
                  fit: BoxFit.cover,
                  height: screenHeight * 0.35, 
                  width: screenWidth * 0.8,
                ):
                Image.asset('images/blankPfp.jpg',
                  fit: BoxFit.cover,
                  height: screenHeight * 0.35, 
                  width: screenWidth * 0.8,
                ),
            ),             
               
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.015,left: screenWidth * 0.03, right: screenWidth * 0.03),
              child: Container(
                padding: const EdgeInsets.all(8),
                // edi content dherai bhayo bhane fix the height 
                constraints: const BoxConstraints(
                  maxHeight: 150,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Text(detectedDisease.ddescription??"")
                ),
              ),
            ),        

          ],
        ),
      ),
    );
  
  }
}