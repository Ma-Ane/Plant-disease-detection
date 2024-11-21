import 'package:flutter/material.dart' ;
import 'dart:io';    // for File datatype


class AfterDetection extends StatelessWidget {
  final File? image ;

  const AfterDetection({super.key, required this.image});

  Widget webLink(String url, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(top:screenWidth * 0.01),
      child: Text(url,
        style: const TextStyle(
          fontSize: 16,
        )
      ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      appBar: AppBar(title: const Text("Disease Detection")),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.02),
                
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(image!,
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
                child: const SingleChildScrollView(
                  child: Text("Browse and download over 70,000 royalty-free images of female profile for your personal or commercial use. Find your perfect picture from various categories, such as woman, portrait, girl, face, and more.Browse and download over 70,000 royalty-free images of female profile for your personal or commercial use. Find your perfect picture from various categories, such as woman, portrait, girl, face, and more.Browse and download over 70,000 royalty-free images of female profile for your personal or commercial use. Find your perfect picture from various categories, such as woman, portrait, girl, face, and more.Browse and download over 70,000 royalty-free images of female profile for your personal or commercial use. Find your perfect picture from various categories, such as woman, portrait, girl, face, and more.")
                ),
              ),
            ),
                
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: screenWidth * 0.03, left: screenWidth * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Here are some of the web searches,",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ) ,
                
                  // yo milaunu parxa paxi
                  webLink("1. www.facebook.com", screenWidth),
                  webLink("2. www.instagram.com", screenWidth),
                  webLink("3. www.whatsapp.com", screenWidth),
                  webLink("4. www.youtube.com", screenWidth),
                ],
              )
            ),
                
            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.03),
              width: double.infinity,     // yo chai center ma na aaoos bhanera
              child: const Text("Nearest Agrostores",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                )
              )
            ),                
          ],
        ),
      ),
    );
  }
}