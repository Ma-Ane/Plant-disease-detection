import 'package:flutter/material.dart' ;

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height ;
    //double screenWidth = MediaQuery.of(context).size.width ;

    // returns the name of class along with some padding
    Widget returnClass (String name) {
      return Column(
        children: [
          SizedBox(height: screenHeight * 0.01),

          Text(name,
            style: const TextStyle(
              fontSize: 15, 
              color: Color.fromARGB(255, 173, 204, 217),
            )
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 66, 80),
      appBar: AppBar(
        title: const Text("Help"),
      ),

      // yo default text color wihte ko lagi but not workingg
      body: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color.fromARGB(255, 173, 204, 217),
              displayColor: Colors.white,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("This app is based on a CNN model, especially Efficient B1 version, that is known for its propert to detect patterns in the image data. This app provides and accuracy of 98.0%, meaning it can correctrly classify 98 diseases from 100 input images.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 173, 204, 217),
                  )
                ),
            
                SizedBox(height: screenHeight * 0.02),
            
                const Text("Here are some of the classes that the app can classify:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    //color: Color.fromARGB(255, 173, 204, 217),
                  )
                ),
            
                returnClass("1.  Apple Apple scab"),
                returnClass("2.  Apple Black rot"),
                returnClass("3.  Apple Cedar apple rust"),
                returnClass("4.  Apple healthy"),
                returnClass("5.  Bacterial leaf blight in rice leaf"),
                returnClass("6.  Blight in corn leaf"),
                returnClass("7.  Blueberry healthy"),
                returnClass("8.  Brown spot in rice leaf"),
                returnClass("9.  Cercospora leaf spot"),
                returnClass("10.  Cherry (including sour) Powdery mildew"),
                returnClass("11.  Cherry (including sour) healthy"),
                returnClass("12.  Common Rust in corn Leaf"),
                returnClass("13.  Corn (maize) healthy"),
                returnClass("14.  Garlic"),
                returnClass("15.  Grape Black rot"),
                returnClass("16.  Grape Esca Black Measles"),
                returnClass("17.  Grape Leaf blight Isariopsis Leaf Spot"),
                returnClass("18.  Grape healthy"),
                returnClass("19.  Gray Leaf Spot in corn Leaf"),
                returnClass("20.  Leaf smut in rice leaf"),
                returnClass("21.  Orange Haunglongbing Citrus greening"),
                returnClass("22.  Peach healthy"),
                returnClass("23.  Pepper bell Bacterial spot"),
                returnClass("24.  Pepper bell Healthy"),
                returnClass("25.  Potato Early blight"),
                returnClass("26.  Potato Late blight"),
                returnClass("27.  Potato healthy"),
                returnClass("28.  Raspberry healthy"),
                returnClass("29.  Sogatella rice"),
                returnClass("30.  Soyabean healthy"),
                returnClass("31.  Strawberry healthy"),
                returnClass("32.  Tomato Bacterial spot"),
                returnClass("33.  Tomato Early blight"),
                returnClass("34.  Tomato Late blight"),
                returnClass("35.  Tomato Leaf Mold"),
                returnClass("36.  Tomato Septoria leaf spot"),
                returnClass("37.  Tomato Spider mites Two spotted spider mite"),
                returnClass("38.  Tomato Target Spot"),
                returnClass("39.  Tomato Tomato mosaic virus"),
                returnClass("40.  Tomato healthy"),
                returnClass("41.  Algal leaf in tea"),
                returnClass("42.  Anthracnose in tea"),
                returnClass("43.  Bird eye spot in rea"),
                returnClass("44.  Brown blight in tea"),
                returnClass("45.  Cabbage looper"),
                returnClass("46.  Corn crop"),
                returnClass("47.  Ginger"),
                returnClass("48.  Healthy tea leaf"),
                returnClass("49.  Lemon canker"),
                returnClass("50.  Onion"),
                returnClass("51.  Potassium deficiency in plant"),
                returnClass("52.  Potato crop"),
                returnClass("53.  Potato hollow heart"),
                returnClass("54.  Red leaf spot in tea"),
                returnClass("55.  Tomato canker"),
                returnClass("56.  Strawberry leaf scorch"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}