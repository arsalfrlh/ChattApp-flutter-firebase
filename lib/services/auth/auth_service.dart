import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; //import liblary Firebase Auth

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance; //menyimpan Firebase Auth di variabel ini
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; //menyimpan Firebase Firestore di variabel ini

  User? getUser(){ //class bawaan User FireBase Auth mengambil data user yg sudah login
    return auth.currentUser;
  }

  Future<UserCredential> login(String email, String password)async{ //class UserCrediterial di Firebase Auth| parameter String
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password); //function bawaan FirebaseAuth

      firebaseFirestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        },
      );

      return userCredential; //mengembalikan UserCrediterial| sama seperti model class User

    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  Future<UserCredential> register(String email, String password)async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      firebaseFirestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        },
      );

      return userCredential;

    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  Future<void> logout()async{
    return await auth.signOut();
  }
}
