import 'dart:io';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_flutter_app/MongoManagement/mongomgmt.dart';


abstract class DbObject{
  Map<String, dynamic> toJson() => {};
}

Account accountFromJson(String str) => Account.fromJson((json.decode(str)));
String accountToJson(Account data) => json.encode(data.toJson());

class Account extends DbObject{
  static Account userAcc = Account(isnull: true);
  static Account accNotFount = Account(isnull: false, firstname: "User not found",lastname: "",email: "",password: "");
   //static Account notfound;

  ObjectId? aid;
  String? firstname;
  String? middlename;
  String? lastname;
  String? email;
  String? password;
  File? pfp;

  bool isnull;

  Account({
    this.aid,
    this.firstname,
    this.middlename,
    this.lastname,
    this.email,
    this.password,
    this.pfp,
    this.isnull = true
  });

  factory Account.fromJson(Map<String, dynamic>? json) { 
    Account x =  Account();
    if(json != null){
      x = Account(
      aid: json["aid"],
      firstname: json["firstname"],
      middlename: json["middlename"],
      lastname: json["lastname"],
      email: json["email"],
      password: json["password"],
      pfp: json["aimage"],
      isnull: false
      );
    }

    return x;
    
  }

  @override
  Map<String, dynamic> toJson() => {
    "aid": aid,
    "firstname": firstname,
    "middlename": middlename,
    "lastname": lastname,
    "email": email,
    "password": password,
    "pfp": pfp,
  };

  static Future<void> insertAcconut(String fname, String mname, String lname, String emaddr, String pw, File? img) async{
    Account check = await retreiveAcconutep(emaddr, pw);
    if(check.isnull == true){
      var id_ = ObjectId();
      final data = Account(aid: id_, firstname: fname,middlename: mname, lastname: lname, email: emaddr,password: pw, pfp: img);

      try{
        await MongoDatabase.insertToDb(data);
        }catch(e){
        rethrow;
     }
    }
    else{
      throw "This account already exists!";
    
    }
  }

  static Future<Account> retreiveAcconutep(String emaddr, String pw) async{
    Account val;
    try{
      val = await MongoDatabase.findAccountep(emaddr,pw);
    }catch(e){
      rethrow;
    }
    return val;
  }

  static Future<Account> retreiveAcconutoi(ObjectId? a) async{
    try{
      if(a != null){
        var val = await MongoDatabase.findAccountoi(a);
        return val;
      }
    }catch(e){
      rethrow;
    }
    return Account(isnull: true);
  }
}

Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());
class Post extends DbObject{
  ObjectId? pid;
  ObjectId? aid;
  List<ObjectId> plikes;
  String? pdescription;
  String? ptitle;
  File? pimg;

  bool isnull;


  Post({
    this.pid,
    this.aid,
    this.plikes = const [],
    this.pdescription,
    this.ptitle,
    this.pimg,
    this.isnull = true
  });

  factory Post.fromJson(Map<String, dynamic>? json){
    Post x = Post();
    List<ObjectId> i = [];

    if(json != null){
      for(ObjectId j in json["plikes"]){
        i.add(j);
      }
      x = Post(
      pid: json["pid"],
      aid: json["aid"],
      plikes: i,
      pdescription: json["description"],
      ptitle: json["title"],
      pimg: json["pimage"],
      isnull: false
      );
    }
    return x;
  }

  @override
  Map<String, dynamic> toJson() {
        
    List<ObjectId> x = [];
    for(var i in plikes){
      x.add(i);
    }
    Map<String,dynamic> json = {
    "pid": pid,
    "aid": aid,
    "plikes": x,
    "pdescription": pdescription,
    "ptitle": ptitle,
    "pimage": pimg,
    };
    return json;
  }

  static Future<void> insertPost(ObjectId? id_, String desc, String tit, File? ima) async{
  var piid = ObjectId();
  final data = Post(pid: piid, aid: id_,plikes: [] ,pdescription: desc, ptitle: tit, pimg: ima);
  try{
  await MongoDatabase.insertToDb(data);
  }catch(e){
      rethrow;
  }
  }

  static Future<List<Post>> retreivePostList() async{
  List<Post> val = await MongoDatabase.findPost();
  return val;
  }

}

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());
class Comment extends DbObject{
  ObjectId? cid;
  ObjectId? pid;
  ObjectId? aid;
  List<ObjectId> clikes;
  String? cdescription;
  ObjectId? posid;
  bool isnull;

  Comment({
    this.cid,
    this.pid,
    this.aid,
    this.clikes = const [],
    this.cdescription,
    this.posid,
    this.isnull = true,
  });

  factory Comment.fromJson(Map<String, dynamic>? json) { 
    Comment c = Comment();
    if(json != null){
      Comment(
        cid: json["cid"],
        pid: json["pid"],
        aid: json["aid"],
        clikes: List<ObjectId>.from(json["clikes"].map((x) => x)),
        cdescription: json["cdescription"],
        posid: json["posid"],
        isnull: false
      );
    }
    return c;
  }

  @override
  Map<String, dynamic> toJson() => {
    "cid": cid,
    "pid": pid,
    "aid": aid,
    "clikes": List<ObjectId>.from(clikes.map((x) => x)),
    "cdescription": cdescription,
    "posid": posid,
  };

  static Future<void> insertComment( ObjectId id_, ObjectId piid, String desc, ObjectId positionid) async{
    var ciid = ObjectId();
    final data = Comment(cid: ciid, aid: id_, pid: piid, clikes: [] ,cdescription: desc, posid: positionid);
    try{
      MongoDatabase.insertToDb(data);
    }catch(e){
      rethrow;
    }
  }

  static Future<Comment> retreiveCommentapc(ObjectId? id_, ObjectId? piid, ObjectId? ciid) async{
    var val = await MongoDatabase.findCommentapc(id_, piid, ciid);
    return val;
  }

  static Future<List<Comment>> retreiveCommentap(ObjectId? id_, ObjectId? piid) async{
    if(id_ != null && piid != null){
      var val = await MongoDatabase.findCommentap(id_, piid);
      return val;
    }
    return [];
  }
}

Disease diseaseFromJson(String str) => Disease.fromJson(json.decode(str));
String diseaseToJson(Disease data) => json.encode(data.toJson());
class Disease extends DbObject {
  ObjectId? did;
  String? jsonNo;
  String? ddescription;
  File? dimg;
  bool isnull;
  
  Disease({
    this.did,
    this.jsonNo,
    this.ddescription,
    this.isnull= true,
    this.dimg
  });

  factory Disease.fromJson(Map<String, dynamic>? json) {
    Disease d = Disease();
    if(json !=null){
      d =  Disease(
        did: json["did"],
        jsonNo: json["json_no"],
        ddescription: json["ddescription"],
        dimg: json["dimg"],
        isnull: false
      );
    }
    return d;
  }

  @override
  Map<String, dynamic> toJson() => {
    "did": did,
    "json_no": jsonNo,
    "ddescription": ddescription,
    "dimg": dimg
  };

  static Future<Disease> retreiveDisease(int jsonNo) async{
    try{
      var val = await MongoDatabase.findDisease(jsonNo);
      return val;
    }catch(e){
      rethrow;
    }
  }

}