import 'package:my_flutter_app/MongoManagement/mongoclasses.dart';
import 'package:mongo_dart/mongo_dart.dart';

const mongoConnUrl ="mongodb+srv://ishangh64:M6HMC~52pj@cluster0.f1b4s.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const usrColl="ProjectData";


class MongoDatabase {
  static late DbCollection userCollection;
  static bool isconnected = false;
  static Object? dbError;

  static Future<void> connect() async{
    try{
      Db db = await Db.create(mongoConnUrl);
      await db.open();
      userCollection = db.collection(usrColl);
      isconnected = true;
    }catch(e){
     dbError = e;
    }
  }
  

  static Future<void> insertToDb(DbObject data) async{
    try{ 
      var result = await userCollection.insertOne(data.toJson()); 
      if(!result.isSuccess){
        throw "Data insertion error.";
      }
    }catch(e){
      rethrow;
    }
  }

  static Future<Account> findAccountep(String emaddr, String pw) async{
    try{ 
     Account result = Account.fromJson(await userCollection.findOne({'email':emaddr, 'password': pw}));
     return result; 
    }catch(e){
      rethrow;
    }
  }

    static Future<Account> findAccountoi(ObjectId A) async{
    try{ 
     var result =  Account.fromJson(await userCollection.findOne({'aid':A}));
     
     return result;     
    }catch(e){
      return Account(isnull: true);
    }
  }

  static Future<List<Post>> findPost() async{
     List<Map<String, dynamic>> result = await userCollection.find(where.exists('ptitle').limit(5)).toList();
     List<Post> x = [];
     for(Map<String,dynamic> y in result){
      x.add(Post.fromJson(y));
     }
     return x;

  }

  static Future<Comment> findCommentapc(ObjectId? id_, ObjectId? piid, ObjectId? ciid) async{
    try{ 
      Map<String,dynamic> x = {};
      id_==null?():x.addAll({"aid":id_});
      piid==null?():x.addAll({"pid":piid});
      ciid==null?():x.addAll({"cid":ciid});
      
      var result =  Comment.fromJson(await userCollection.findOne());
      return result;
       
    }catch(e){
      rethrow;
    }
  }

  static Future<List<Comment>> findCommentap(ObjectId id_, ObjectId piid) async{
    List<Map<String, dynamic>> result = await userCollection.find({'id':id_, 'pid':piid}).toList();
    List<Comment> r =[];
    for(Map<String, dynamic> x in result){
      r.add(Comment.fromJson(x));
    }
    return r;   
  }

  static Future<Disease> findDisease(int jsonnum) async{
    try{ 
     var result = Disease.fromJson(await userCollection.findOne({'jsonNo':jsonnum}));
     return result;     
    }catch(e){
      return Disease();
    }
  }
}