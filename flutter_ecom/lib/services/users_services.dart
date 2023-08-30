import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //método para registrar usuário no firebase
  signUp(String email, String password, String userName) {
    _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  signIn(String email, String password) {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // saveUserDetails() {
  //   _firestore.collection('users').add(data);
  // }
}