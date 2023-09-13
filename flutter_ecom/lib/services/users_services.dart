import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/models/users.dart';
import 'package:flutter/material.dart';

class UsersServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Users? users = Users();

  DocumentReference get _firestoreRef => _firestore.doc('/users/${users!.id}');
  //método para registrar usuário no firebase
  Future<bool> signUp(Users users) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
        email: users.email!,
        password: users.password!,
      ))
          .user;

      this.users!.id = user!.uid;
      this.users!.email = user.email;
      this.users!.userName = users.userName!;
      this.users!.birthday = users.birthday!;
      this.users!.phone = users.phone!;

      saveUser();
      return true;
    } on FirebaseAuthException catch (e) {
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

  Future<bool> signIn(
      {String? email,
      String? password,
      Function? onSucess,
      Function? onFail}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      onSucess!();
      return true;
    } on FirebaseAuthException catch (ex) {
      String? erro;
      if (ex.code == 'wrong-password') {
        erro = "Senha incorreta!";
      } else if (ex.code == 'invalid-email') {
        erro = "E-mail inválido";
      } else if (ex.code == 'user-not-found') {
        erro = "Usuário não encontrado";
      } else {
        erro = ex.toString();
      }

      onFail!(erro);
      debugPrint("\n${ex.toString()}\n");
    }
    return false;
  }

  saveUser() {
    _firestoreRef.set(users!.toJson());
  }
}
