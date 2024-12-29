import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
import 'package:mongo_dart/mongo_dart.dart';

const mongoConnUrl ="mongodb+srv://ishangh64:M6HMC~52pj@cluster0.f1b4s.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const usrColl="ProjectData";


class MongoDatabase {
    static var userCollection;
    static connect() async{
    Db db = await Db.create(mongoConnUrl);
    await db.open();
    userCollection = db.collection(usrColl);
  }

  static Future<String> insertToDb(DbObject data) async{
    try{ 
     var result = await userCollection.insertOne(data.toJson()); 
     if(result.isSuccess){
      return "Data inserted Successfully.";
     }
     else{
      return "Data insertion error.";
     }
    }catch(e){
      return "Data insertion error.";
    }
  }

  static Future<Account?> findUser(String emaddr, String pw) async{
    try{ 
     var result = await userCollection.findOne({'email':emaddr, 'password': pw}).fromJson();
     return result;     
    }catch(e){
      return null;
    }
  }

  static Future<Post?> findPost() async{
    try{ 
     var result = await userCollection.findOne().fromJson();
     return result;     
    }catch(e){
      return null;
    }
  }

  static Future<Comment?> findComment(ObjectId? id_, ObjectId? piid, ObjectId? ciid) async{
    try{ 
     var result = await userCollection.findOne({'id':id_, 'pid':piid, 'cid': ciid}).fromJson();
     return result;     
    }catch(e){
      return null;
    }
  }

  static Future<Disease?> findDisease(String jsonnum) async{
    try{ 
     var result = await userCollection.findOne({'jsonNo':jsonnum}).fromJson();
     return result;     
    }catch(e){
      return null;
    }
  }
}