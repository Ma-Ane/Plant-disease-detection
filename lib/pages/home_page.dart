import 'package:flutter/material.dart' ;
import "dart:io" ;
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/pages/post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color homepageBackground = const Color(0xFF83a84f); 
  final Color homepageback = const Color(0xFF547027);
  final Color homepageTextbg = const Color(0xFFAFD06E); 

  final ImagePicker _picker = ImagePicker();
  File? image ;

  // paxi chaina sakxqa
  // like button
  bool isliked = false ;

  void name() {}

  // user ko naam ra profile pic
  Widget _returnUserData(String userName, String userPic) {
    return Row(
      children: [
        
        // clivoval le photo lai round banauxa
        ClipOval(
          child: Image.asset(userPic, 
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
          ), 
        ),

        const SizedBox(width: 30),

        // user name
        Text(userName, 
          style: const TextStyle(
            fontSize: 22,
          )
        ),
      ],
    );   
  }

  // esle query ko photo return garxa.. bhaneko leaf ko photo
  Widget _queryPhoto(String leaf, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height ;
    // clipreact user gareraa border radius rakheko
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(leaf,
          fit: BoxFit.fill,
          height: screenHeight *0.12,
          width: screenHeight * 0.12,  
        ),
      );
  }

  // sabai post ko lagi chuttai chuttai garna baki xa like button
  void toggleLike() {
    setState(() {
      isliked = !isliked ;
    });
  }

  // gallery kholne aafno mob ko
  Future _galleryOption() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery) ;

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path) ;
      });
    }
  }


  // esle euta query return garxa pura box
  Widget _returnQuery(BuildContext context, name, String photo, String leaf, String description, bool isliked) {
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;
    return Padding(
      padding: const EdgeInsets.only(top:10.0, left: 10, right: 10),

      // euta query ko lagi container
      child: Container(

        // tyo container ko property
         decoration: BoxDecoration(
          // edi color use garne bhaye
          gradient: const RadialGradient(
            radius: 2.5,
            colors:[
              Color.fromARGB(255, 52, 66, 80),
              Color.fromARGB(255, 15, 26, 21),
              Color.fromARGB(255, 76, 86, 96),
            ],
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        height: screenHeight * 0.25,                // height aaba content ko length ma depend garxa
        width: double.infinity,

        // container bhitra euta column , euta user data ko lagi euta query ko lagi
        child: Column(
          children: [

            // user ko pic ra naam bhako wala container 
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 63, 155, 104),
                borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
              ),

              // container ma euta row for name and pic
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top:15, left: 10, right: 10),

                    // esle chai db bata naam ra photo linxa
                    child: _returnUserData(name, photo),
                  ),
                ],
              ),
            ),

            // yo chaidescription ra leaf ko pic ko lagi
            Padding(
              padding: const EdgeInsets.only(top:10.0),

              // description ra leaf ali euta row ma rakheko
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:0.0, left: 20),

                    // row bhitra euta container for description
                    child: Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(0, 0, 0, 0),//Color.fromARGB(255, 169, 245, 77),
                      ),
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.55,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        // db bata linee
                        child: Text(description
                        , style: TextStyle(
                          color: Colors.white
                        )),
                      ),
                    ),
                  ),

                  // yo chai photo lai milauna ko lagi left side ma
                  // eslai responsibe banuanee
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: _queryPhoto(leaf,context),
                  ),
                ],
              ),
            ),

            // eslaii db sangai link ani sabai query lai link bhako hataune
            // comment ra like button ko lagi
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20),
                  child: GestureDetector(
                    onTap: toggleLike,

                    // like ko button change garna ko lagi
                    child: Icon(isliked ? Icons.favorite : Icons.favorite_border, 
                        size: 28, color: Color.fromARGB(255, 212, 113, 104),
                      ),
                  ),
                ),

                // yo ta comment box ko lagii
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context, 

                      // euta dialog box
                      builder: (context) => Dialog(

                        // bahira ko container 
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50) ,
                            color: Colors.white,
                          ),
                          height: 600,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),

                            // column sabaii icon haru ko lagi
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // yoo back button ho
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop() ;
                                  }, 
                                  child: const Icon(Icons.keyboard_backspace_rounded, size: 28)
                                ),

                                const SizedBox(height: 20),

                                // yo main box comment haru herne
                                Container(
                                  height: 400,
                                  width: 400,
                                  color: Colors.grey,
                                ),

                                // yo aafno comment type garne
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0, left: 5),

                                  // row for comment lekhne ani photo icon
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 270,
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            hintText: "Type a comment...",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:10.0),
                                        child: GestureDetector(
                                          onTap: _galleryOption, 
                                          child: const Icon(Icons.add_a_photo,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // post button 
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: MaterialButton(
                                    color: Colors.green,
                                    hoverColor: Colors.lightGreenAccent,
                                    onPressed: () {
                                      Navigator.of(context).pop() ;
                                      //_postComment ;
                                    },
                                    child: const Text("Post",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ) ;
                  },
                  child: const Icon(Icons.comment,color: Color.fromARGB(255, 87, 143, 93),), 
                )
              ],
            ),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // yo chai ali milaunu parxa hola haii query haru lai ramrarii dekhaunaa
    return ListView.builder(
      itemCount: 1,       // esle tala bhako sabai content ek choti matrai dekhauxaa
      itemBuilder: (context, index){ 

      // overall container pura screen ko lagi
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:15.0, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 63, 155, 104),
              ),
              height: 140,
              width: double.infinity,

              // bhitra ko column aafno info ko 
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0, left: 10),
                    child: Row(
                      // yo naam ra pic ko lagi
                      children: [
                        _returnUserData("Manjit Maharjan", "images/profile_pic.jpg"),
      
                        const SizedBox(width: 50),

                        // yo chai plus button forposting
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFFB4d3b2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const PostPage())) ;
                              },
                              child: const Icon(Icons.add)
                            ),
                          )
                        ),
                      ],
                    ),
                  ),

                  // yo post your query bhako wala box ra icon
                  Padding(
                    padding: const EdgeInsets.only(top:20.0, bottom: 10, left: 20),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFB4d3b2)
                          ),
                          height: 45,
                          width: 280,
                          child: const Padding(
                            padding: EdgeInsets.only(top:8.0, left: 25),
                            child: Text('Post your query ?',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              )
                            ),
                          ),
                        ),
      
                        const SizedBox(width: 20),

                        // gallery icon
                        const Icon(Icons.photo_album,
                          size: 35,
                          color: Color.fromARGB(255, 207, 216, 200),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        // eslee harek user ko query return garxxa
        _returnQuery(context, "Ishan Ghimire", 'images/profile2.jpg', 'images/leaf1.jpg', "Hello, I have been using this app for quite a long time and think that this app is great and can help other users in identifying the disease and also provide some recommendations based on the result.", isliked),
        _returnQuery(context, "Mandip Shrestha", 'images/profile3.jpg', 'images/leaf2.jpg', "Hello, I have been using this app for quite a long time and think that this app is great and can help other users in identifying the disease and also provide some recommendations based on the result.", isliked),
        _returnQuery(context, "Jyoti Kumari Gupta", 'images/profile4.jpg', 'images/leaf3.jpg', "Hello, I have been using this app for quite a long time and think that this app is great and can help other users in identifying the disease and also provide some recommendations based on the result.", isliked),
        ],
      ) ;
      }
    );
  }
}