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
  final ImagePicker _picker = ImagePicker();
  File? image ;

  // paxi chaina sakxqa
  bool isliked = false ;

  void name() {}

  Widget _returnUserData(String userName, String userPic) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(userPic, 
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
          ), 
        ),

        const SizedBox(width: 30),

        Text(userName, 
          style: const TextStyle(
            fontSize: 22,
          )
        ),
      ],
    );   
  }

  Widget _queryPhoto(String leaf) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(leaf,
          fit: BoxFit.fill,
          height: 140,
          width: 120,  
        ),
      );
  }

  // sabai post ko lagi chuttai chuttai garna baki xa like button
  void toggleLike() {
    setState(() {
      isliked = !isliked ;
    });
  }

  Future _galleryOption() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery) ;

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path) ;
      });
    }
  }

  // Future _postComment() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       child: Align(
  //         alignment: Alignment.bottomLeft,
  //         child: Container(
  //           height:100,
  //           width: 300,
  //           decoration: BoxDecoration(
  //             color: Colors.grey,
  //           )
  //         ),
  //       ),
  //     ),
  //   ) ;
  // }

  Widget _returnQuery(String name, String photo, String leaf, String description, bool isliked) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
          borderRadius: BorderRadius.circular(10)
        ),
        height: 253,                // height aaba content ko length ma depend garxa
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:15.0, left: 10, right: 10),
                  child: _returnUserData(name, photo),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:0.0, left: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 169, 245, 77),
                    ),
                    height: 100,
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(description),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: _queryPhoto(leaf),
                ),
              ],
            ),

            // comment ra like button ko lagi
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20),
                  child: GestureDetector(
                    onTap: toggleLike,
                    child: Icon(isliked ? Icons.favorite : Icons.favorite_border, 
                        size: 28
                      ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context, 
                      builder: (context) => Dialog(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50) ,
                            color: Colors.white,
                          ),
                          height: 600,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop() ;
                                  }, 
                                  child: const Icon(Icons.keyboard_backspace_rounded, size: 28)
                                ),

                                const SizedBox(height: 20),

                                Container(
                                  height: 400,
                                  width: 400,
                                  color: Colors.grey,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0, left: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 270,
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            hintText: "Type a comment.. ",
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
                  child: const Icon(Icons.comment), 
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
    return ListView.builder(
      itemCount: 1,       // esle tala bhako sabai content ek choti matrai dekhauxaa
      itemBuilder: (context, index){ 
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:15.0, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightGreenAccent,
              ),
              height: 140,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0, left: 10),
                    child: Row(
                      children: [
                        _returnUserData("Manjit Maharjan", "images/profile_pic.jpg"),
      
                        const SizedBox(width: 50),
      
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.lightGreen,
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
                  Padding(
                    padding: const EdgeInsets.only(top:20.0, bottom: 10, left: 20),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.lightGreen
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
      
                        const Icon(Icons.photo_album,
                          size: 35,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        _returnQuery("Ishan Ghimire", 'images/profile2.jpg', 'images/leaf1.jpg', "Hello, I have been using this app for quite a long time and think that this app is great and can help other users in identifying the disease and also provide some recommendations based on the result.", isliked),
        _returnQuery("Mandip Shrestha", 'images/profile3.jpg', 'images/leaf2.jpg', "Hello, I have been using this app for quite a long time and think that this app is great and can help other users in identifying the disease and also provide some recommendations based on the result.", isliked),
        _returnQuery("Jyoti Kumari Gupta", 'images/profile4.jpg', 'images/leaf3.jpg', "Hello, I have been using this app for quite a long time and think that this app is great and can help other users in identifying the disease and also provide some recommendations based on the result.", isliked),
        ],
      ) ;
      }
    );
  }
}