import 'package:flutter/material.dart' ;

class History extends StatelessWidget {
  const History({super.key});

  // euta dabba dinxa history ko
  Widget returnHistory(BuildContext context, String diseaseName, String image) {
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.03, right: screenWidth * 0.03),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 63, 155, 104),
          borderRadius: BorderRadius.circular(10),
        ),
        height: screenHeight * 0.1,
        width: double.infinity,

        // row for disease name and photo
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(diseaseName, style: const TextStyle(fontSize: 22),),
          
              Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 66, 80),
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: SingleChildScrollView(
        // overall bahira ko column
        child: Column(
          children: [
            returnHistory(context, 'Tomato Early Blight', 'images/leaf1.jpg'),
            returnHistory(context, 'Potato Healthy', 'images/leaf2.jpg'),
            returnHistory(context, 'Apple Scab', 'images/leaf3.jpg'),
            returnHistory(context, 'Mango Healthy', 'images/leaf2.jpg'),
            returnHistory(context, 'Tomato Healthy', 'images/leaf1.jpg'),
          ],
        ),
      ),
    );
  }
}