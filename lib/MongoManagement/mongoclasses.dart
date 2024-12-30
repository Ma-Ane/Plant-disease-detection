import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_flutter_app/MongoManagement/mongomgmt.dart';
import 'dart:convert';

String? imgtostr(File? ima){
  if(ima == null){
    return null;
  }
  var imglist = ima.readAsBytes() as List<int>;
  var imagestr = base64Encode(imglist);
  return imagestr;
}
  
File strtoimg(String? str, String? imgtype){
  if(str == null || imgtype == null){
    return File('images/profile_pic.jpg');
  }
  var bytes = base64.decode(str);
  File file =File(DateTime.now().millisecondsSinceEpoch.toString() + "." + imgtype);
  file.writeAsBytes(bytes);
  return file;
}

abstract class DbObject{
  Map<String, dynamic> toJson() => {};
}

Account accountFromJson(String str) => Account.fromJson((json.decode(str)));
String accountToJson(Account data) => json.encode(data.toJson());

class Account extends DbObject{
   static Account? userAcc;
   //static Account notfound;

    ObjectId aid;
    String firstname;
    String middlename;
    String lastname;
    String email;
    String password;
    String? pfp;
    String? pfptype;

    Account({
        required this.aid,
        required this.firstname,
        required this.middlename,
        required this.lastname,
        required this.email,
        required this.password,
        required this.pfp,
        required this.pfptype,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        aid: json["aid"],
        firstname: json["firstname"],
        middlename: json["middlename"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        pfp: json["aimage"],
        pfptype: json["aimgtype"],
    );

    @override
    Map<String, dynamic> toJson() => {
        "aid": aid,
        "firstname": firstname,
        "middlename": middlename,
        "lastname": lastname,
        "email": email,
        "password": password,
        "pfp": pfp,
        "pfptype": pfptype,
    };

  static Future<String> insertAcconut(String fname, String mname, String lname, String emaddr, String pw, File? img, String? impty) async{
  final check = await retreiveAcconutep(emaddr, pw);
  if(check != null){

  var id_ = ObjectId();
  var imgstr = imgtostr(img);
  final data = Account(aid: id_, firstname: fname,middlename: mname, lastname: lname, email: emaddr,password: pw, pfp: imgstr, pfptype: impty);

  try{
  String result = await MongoDatabase.insertToDb(data);
  
  return result;
  }catch(e){
      return e.toString();
  }
  }
  else{
    return "This email is already used by an account!";
  }
  }

  static Future<Account?> retreiveAcconutep(String emaddr, String pw) async{
  var val = await MongoDatabase.findAccountep(emaddr,pw);
  return val;
  }
  static Future<Account?> retreiveAcconutoi(ObjectId a) async{
  var val = await MongoDatabase.findAccountoi(a);
  return val;
  }
}


Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());
class Post extends DbObject{
    ObjectId pid;
    ObjectId aid;
    List<ObjectId> plikes;
    String pdescription;
    String ptitle;
    String? pimg;
    String? pimgtype;

    Post({
        required this.pid,
        required this.aid,
        required this.plikes,
        required this.pdescription,
        required this.ptitle,
        this.pimg,
        this.pimgtype,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        pid: json["pid"],
        aid: json["aid"],
        plikes: List<ObjectId>.from(json["plikes"].map((x) => x)),
        pdescription: json["description"],
        ptitle: json["title"],
        pimg: json["pimage"],
        pimgtype: json["pimgtype"],
    );

    @override
    Map<String, dynamic> toJson() => {
        "pid": pid,
        "aid": aid,
        "plikes": List<ObjectId>.from(plikes.map((x) => x)),
        "pdescription": pdescription,
        "ptitle": ptitle,
        "pimage": pimg,
        "pimgtype": pimgtype,
    };

  static Future<String> insertPost(ObjectId id_, String desc, String tit, File? ima, String? type) async{
  var piid = ObjectId();
  var imagestr = imgtostr(ima);
  final data = Post(pid: piid, aid: id_,plikes: [] ,pdescription: desc, ptitle: tit, pimg: imagestr, pimgtype:type);
  try{
  String result = await MongoDatabase.insertToDb(data);
  return result;
  }catch(e){
      return e.toString();
  }
  }

  static Future<List<Post>> retreivePostList() async{
  var val = await MongoDatabase.findPost();
  return val;
  }

}

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());
class Comment extends DbObject{
    ObjectId cid;
    ObjectId pid;
    ObjectId aid;
    List<ObjectId> clikes;
    String cdescription;
    ObjectId? posid;

    Comment({
        required this.cid,
        required this.pid,
        required this.aid,
        required this.clikes,
        required this.cdescription,
        required this.posid,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        cid: json["cid"],
        pid: json["pid"],
        aid: json["aid"],
        clikes: List<ObjectId>.from(json["clikes"].map((x) => x)),
        cdescription: json["cdescription"],
        posid: json["posid"],
    );

    @override
    Map<String, dynamic> toJson() => {
        "cid": cid,
        "pid": pid,
        "aid": aid,
        "clikes": List<ObjectId>.from(clikes.map((x) => x)),
        "cdescription": cdescription,
        "posid": posid,
    };

    static Future<String> insertComment( ObjectId id_, ObjectId piid, String desc, ObjectId positionid) async{
  var ciid = ObjectId();
  final data = Comment(cid: ciid, aid: id_, pid: piid, clikes: [] ,cdescription: desc, posid: positionid);
  try{
  String result = await MongoDatabase.insertToDb(data);
  return result;
  }catch(e){
      return e.toString();
  }
  }

  static Future<Comment?> retreiveCommentapc(ObjectId? id_, ObjectId? piid, ObjectId? ciid) async{
  var val = await MongoDatabase.findCommentapc(id_, piid, ciid);
  return val;
  }

  static Future<List<Comment>> retreiveCommentap(ObjectId id_, ObjectId piid) async{
  var val = await MongoDatabase.findCommentap(id_, piid);
  return val;
  }
}

Disease diseaseFromJson(String str) => Disease.fromJson(json.decode(str));
String diseaseToJson(Disease data) => json.encode(data.toJson());
class Disease extends DbObject {
    ObjectId did;
    String jsonNo;
    String ddescription;

    Disease({
        required this.did,
        required this.jsonNo,
        required this.ddescription,
    });

    factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        did: json["did"],
        jsonNo: json["json_no"],
        ddescription: json["ddescription"],
    );

    @override
    Map<String, dynamic> toJson() => {
        "did": did,
        "json_no": jsonNo,
        "ddescription": ddescription,
    };

  static Future<Disease?> retreiveDisease(String jsonNo) async{
  var val = await MongoDatabase.findDisease(jsonNo);
  return val;
  }
}