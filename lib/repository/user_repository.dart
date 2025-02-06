

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship_task_firebase/model/user_model/user_model.dart';

class UserRepository{

  final CollectionReference _user  = FirebaseFirestore.instance.collection('users');

  Future<void>saveData(UserModel  user)async{
    await _user.doc(user.uid).set(user.toMap());
  }

  Future<UserModel?>getData(String  uid)async{
    DocumentSnapshot  doc = await _user.doc(uid).get();
    if(doc.exists){
      return  UserModel.fromMap(doc.data()  as  Map<String,dynamic>);
    }
    return  null;
  }

}