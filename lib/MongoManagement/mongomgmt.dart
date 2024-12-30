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
      throw "Data insertion error.";
     }
    }catch(e){
      return e.toString();
    }
  }

  static Future<Account?> findAccountep(String emaddr, String pw) async{
    try{ 
     var result = await userCollection.findOne({'email':emaddr, 'password': pw}).fromJson();
     return result;     
    }catch(e){
      return null;
    }
  }

    static Future<Account?> findAccountoi(ObjectId A) async{
    try{ 
     var result = await userCollection.findOne({'aid':A}).fromJson();
     return result;     
    }catch(e){
      return null;
    }
  }

  static Future<List<Post>> findPost() async{
     List<Map<String, dynamic>> result = await userCollection.aggregate([{'\$sample': {'size': 5}}]);
     List<Post> x = [];
     for(var y in result){
      x.add(Post.fromJson(y));
     }

     return x;
  }

  static Future<Comment?> findCommentapc(ObjectId? id_, ObjectId? piid, ObjectId? ciid) async{
    try{ 
     var result = await userCollection.findOne({'id':id_, 'pid':piid, 'cid': ciid}).fromJson();
     return result;     
    }catch(e){
      return null;
    }
  }
  static Future<List<Comment>> findCommentap(ObjectId id_, ObjectId piid) async{
    var result = await userCollection.find({'id':id_, 'pid':piid}).toList();
    return result;   
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