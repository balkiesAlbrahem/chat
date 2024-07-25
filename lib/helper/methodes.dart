
// import 'package:firebase_auth/firebase_auth.dart';

// Future <User> createAcount (String name,String email,String password)async{

// FirebaseAuth _auth = FirebaseAuth.instance;
// try{
//   User user =(await _auth.createUserWithEmailAndPassword(email : email , password : password)).user;
// if(user != null){
// print("login succesfull");
// return user;
// }
// else{
// print("Account creation failed ");
// return user;
// }
// }
// catch(e){
// print(e);
// return null;
// }

// }




// Future <User> logIn (String email,String password) async {

// FirebaseAuth _auth = FirebaseAuth.instance;
// try{
//   User user =(await _auth.signInWithEmailAndPassword(email : email , password : password)).user;
// if(user != null){
// print("login succesfull");
// return user;
// }
// else{
// print("login failed ");
// return user;
// }
// }
// catch(e){
// print(e);
// return null;
// }

// }


// Future <User> logOut (String email,String password) async {

// FirebaseAuth _auth = FirebaseAuth.instance;
// try{
//   await _auth.signOut();
// }
// catch(e){
// print(e);
// print("error")
// return null;
// }

// }

