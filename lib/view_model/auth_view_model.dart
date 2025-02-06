

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:internship_task_firebase/model/user_model/user_model.dart';
import 'package:internship_task_firebase/repository/user_repository.dart';

class AuthViewModel with  ChangeNotifier{

  final FirebaseAuth  _auth = FirebaseAuth.instance;
  final UserRepository  _userRepository =UserRepository();

  User? _firebaseUser;
  UserModel?  _userModel;

  User? get firebaseUser  =>  _firebaseUser;
  UserModel?  get userModel =>  _userModel;

  AuthViewModel(){
    _auth.authStateChanges().listen((user){
      _firebaseUser =user;
      if(user!=null){
       fetchUserData(user.uid);
      }
      notifyListeners();
    });
  }
 Future<void>signUp(String  name, String  email,  String  password)async{
  try{
    UserCredential userCredential  = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password);
    User? user  = userCredential.user;
  if(user!=null){
    UserModel newUser=UserModel(
      uid: user.uid,name: name,email: email
    );
    await _userRepository.saveData(newUser);
    _userModel  = newUser;
    notifyListeners();
    }
  }catch(e){
    print('SignUp Error $e');
  }
  }
  Future<void>login(String email, String  password)async{
    UserCredential  userCredential  = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User?  user  = userCredential.user;
    if(user!=null){
      fetchUserData(user.uid);
    }
  }
  Future<void>logout()async{
    await _auth.signOut();
    _firebaseUser=null;
    _userModel=null;
    notifyListeners();

  }
  Future<void>fetchUserData(String  uid)async{
    _userModel  = await _userRepository.getData(uid);
    notifyListeners();

 }



}