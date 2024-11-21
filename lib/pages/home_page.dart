import 'package:flutter/material.dart' ;
import 'package:my_flutter_app/pages/post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                // IconButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context, 
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: Text("Comment Section"), 
                //           content: Column(
                //             children: [

                //             ],
                //           ),
                //           actions: [
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.of(context).pop() ;
                //               }, 
                //               child: const Text("Post")
                //             ),
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.of(context).pop() ;
                //               }, 
                //               child: const Text("OK")
                //             )
                //           ],
                //         ) ;
                //       }
                //     ) ;
                //   },
                //   icon: const Icon(Icons.comment)
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PostPage())) ;
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