import 'package:flutter/material.dart' ;
import "dart:io" ;
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
import 'package:my_flutter_app/pages/post_page.dart';

class Postinfo{
  late String username;
  late Image userImg;
  late Image postImg;
  late String postdescription;
  bool isliked = false;
  List<Widget> commentlist = []; 

  Postinfo(this.username, this.userImg, this.postImg, this.postdescription, this.isliked);

  Postinfo.getPostInfo(Account A, Post P, Map<Comment,Account> C, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height ;
    double screenWidth = MediaQuery.of(context).size.width ;
    username = "${A.firstname} ${A.middlename} ${A.lastname}";
    userImg = Image(image: FileImage(A.pfp??File('images/blankPfp.jpg')),fit: BoxFit.cover,height: 50,width: 50);
    postImg = Image(image: FileImage(P.pimg??File('images/blankPfp.jpg')),fit: BoxFit.fill,height: screenHeight *0.12,width: screenHeight * 0.12);
    postdescription = P.pdescription??"Description null";
    for(var x in P.plikes){
      if(x==A.aid){
        isliked = true;
        break;
      }
    }
    for(var x in C.entries){
      _HomePageState.returnComment(screenHeight * 0.4, screenWidth * 0.9, x.value,x.key);
    }
  }
  
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color homepageBackground = const Color(0xFF83a84f); 
  final Color homepageBack = const Color(0xFF547027);
  final Color homepageTextBg = const Color(0xFFAFD06E);

  final ImagePicker _picker = ImagePicker();
  File? image ;

  void name() {}
  // user ko naam ra profile pic
  Widget _returnUserData(String userName, Image userPic) {
    return Row(
      children: [

        ClipOval(
          child: userPic
        ),

        const SizedBox(width: 15),

        // user name
        Text(userName, 
          style: const TextStyle(
            fontSize: 22,
          )
        ),
      ],
    );   
  }



  // sabai post ko lagi chuttai chuttai garna baki xa like button
  Future toggleLike()async {
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


  // each comment lai dekhauxaa
  static Widget returnComment (double height, double width, Account A, Comment c) {
    Image userpfp = Image(image: Account.userAcc.pfp !=null?
      FileImage(Account.userAcc.pfp!):
      const AssetImage("images/blankPfp.jpg"),
      height: height*0.1
    );
    return Padding(
      padding: const EdgeInsets.all(10.0),
      // row for pic and comment
      child: Row (
        children: [
          ClipOval(
            child: userpfp,
          ),
    
          SizedBox(width: width * 0.02,),
    
          // comment
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 209, 209),
              borderRadius: BorderRadius.circular(50),
            ),
            height: height * 0.1,
            width: width * 0.5,
            child: Padding (
              padding: const EdgeInsets.all(8.0),
              child: Text(c.cdescription??"Description null"),
            ),
          ),
        ],
      ),
    ) ;
  }

  
  Future<List<Widget>> getposts(BuildContext context) async{
    List<Post> p = await Post.retreivePostList();
    List<Account> a =[];    
    List<Comment> temp;
    Account? atemp;
    Map<Comment,Account> mtemp ={};
    List<Map<Comment,Account>> m = [];
    List<Widget> rq = [];

    for(Post x in p){
      var temp = await Account.retreiveAcconutoi(x.aid);
      if(temp.isnull == true){
       a.add(Account.accNotFount);
      }
      else{
        a.add(temp);
      }
    }

    for (var i = 0; i < p.length; i++) {
      temp = await Comment.retreiveCommentap(a[i].aid, p[i].pid);
      for(var j = 0; j < temp.length; j++){
          atemp = await Account.retreiveAcconutoi(temp[i].aid);
          if(atemp.isnull == false){
            mtemp[temp[i]] = atemp;
          }
      }
    m.add(mtemp);
    }

    for(var i = 0; i<p.length; i++){
        if (context.mounted) {
          rq.add(_returnQuery(context,Postinfo.getPostInfo(a[i], p[i], m[i], context)));
        }
    }

    return rq;
  }
  

  // esle euta query return garxa pura box
  Widget _returnQuery(BuildContext context, Postinfo pi){
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
                    child: _returnUserData(pi.username, pi.userImg),
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
                      decoration: const BoxDecoration(
                        color:  Color.fromARGB(0, 0, 0, 0),//Color.fromARGB(255, 169, 245, 77),
                      ),
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.55,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        // db bata linee
                        child: Text(pi.postdescription
                        , style: const TextStyle(
                          color: Colors.white
                        )),
                      ),
                    ),
                  ),

                  // eslai responsibe banuanee
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: ClipRRect(
                      child: pi.postImg,
                    )
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
                    child: Icon(pi.isliked ? Icons.favorite : Icons.favorite_border, 
                        size: 28, color: const Color.fromARGB(255, 212, 113, 104),
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
                          height: screenHeight * 0.65,
                          width: screenWidth * 0.9,
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
                                SingleChildScrollView(
                                  child: Container(
                                    height: screenHeight * 0.4,
                                    width: screenWidth * 0.9,
                                    color: const Color.fromARGB(255, 189, 186, 186),
                                  
                                    // harek comment 
                                    child: Column(
                                      children: [...pi.commentlist],
                                    ),
                                  ),
                                ),

                                // yo aafno comment type garne
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0, left: 5),

                                  // row for comment lekhne ani photo icon
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        height: 70,
                                        width: 270,
                                        child: TextField(
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
    
    Image userPic = Image(image: Account.userAcc.pfp !=null?
      FileImage(Account.userAcc.pfp!):
      const AssetImage("images/blankPfp.jpg"),
      fit: BoxFit.cover,
      height: 50,width: 50
    );

    String userName = "${Account.userAcc.firstname} ${Account.userAcc.middlename} ${Account.userAcc.lastname}";

     Future<List<Widget>> futureList =  getposts(context);
     List<Widget> posts =[];
     futureList.then((list){
      posts.insertAll(0, list);
     });
  // Use .then() to handle the resolved list

    return ListView.builder(
      itemCount: 1,       // esle tala bhako sabai content ek choti matrai dekhauxaa
      itemBuilder: (context, index){ 

      // overall container pura screen ko lagi
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        _returnUserData(userName, userPic),
      
                        const SizedBox(width: 5),

                        // yo chai plus button forposting
                        Align(
                          alignment: Alignment.topLeft,
                          child:Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xFFB4d3b2),
                            ),
                            child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/post_page"),builder: (context) => const PostPage())) ;
                              },
                              child: const Icon(Icons.add)
                            ),
                          )
                        ),
                        )
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
                            color: const Color(0xFFB4d3b2)
                          ),
                          height: 45,
                          width: 280,
                          child: Padding(
                            padding: const EdgeInsets.only(top:8.0, left: 25),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/post_page"),builder: (context) => const PostPage())) ;
                              },
                              child: const Text('Post your query?',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                )
                              ),
                            ),
                          ),
                        ),
      
                        const SizedBox(width: 20),

                        // gallery icon
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(settings: const RouteSettings(name: "/post_page"),builder: (context) => const PostPage())) ;
                          },
                          child: const Icon(Icons.photo_album,
                            size: 35,
                            color: Color.fromARGB(255, 207, 216, 200),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ...posts

        ],
      ) ;
      }
    );
  }
}