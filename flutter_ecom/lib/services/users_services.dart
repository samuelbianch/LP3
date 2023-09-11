import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/models/users.dart';
import 'package:flutter/material.dart';

class UsersServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Users? users;

  DocumentReference get _firestoreRef => _firestore.doc('/users/${users!.id}');
  //método para registrar usuário no firebase
  Future<bool> signUp(String email, String password, String userName) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;

      users!.id = user!.uid;
      users!.email = user.email;
      users!.userName = userName;

      saveUser();
      return true;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'invalid-email') {
        debugPrint('Email informado é inválido');
      } else if (e.code == 'weak-password') {
        debugPrint('A senha precisa ter no mínimo 6 caracteres');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('Já existe cadastro com este email!!');
      } else {
        debugPrint("Algum erro aconteceu na Plataforma do Firebase");
      }
      return false;
    }
  }

  signIn(String email, String password) {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  saveUser() {
    _firestoreRef.set(users!.toJson());
  }
}