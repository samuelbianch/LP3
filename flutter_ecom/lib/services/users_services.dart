import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecom/models/users.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UsersServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Users? users = Users();

  DocumentReference get _firestoreRef => _firestore.doc('/users/${users!.id}');
  CollectionReference get _collectionRef => _firestore.collection('users');
  UsersServices() {
    _loadingCurrentUser();
  }

  //método para registrar usuário no firebase
  Future<bool> signUp(Users users, dynamic imageFile, bool plat) async {
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
      _uploadImage(imageFile, plat);
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
      User? user = (await _auth.signInWithEmailAndPassword(
              email: email!, password: password!))
          .user;
      onSucess!();
      _loadingCurrentUser();
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

  saveUser() async {
    await _firestoreRef.set(users!.toJson());
  }

  _loadingCurrentUser({User? user}) async {
    User? curretUser = user ?? _auth.currentUser;
    if (curretUser != null) {
      DocumentSnapshot docUser =
          await _firestore.collection("users").doc(curretUser.uid).get();
      users = Users.fromJson(docUser);
      notifyListeners();
    }
  }

  _uploadImage(dynamic imageFile, bool plat) async {
    //chave para persistir a imagem no firebasestorage
    final uuid = const Uuid().v1();
    try {
      Reference storageRef = _storage.ref().child('users').child(users!.id!);
      //objeto para realizar o upload da imagem
      UploadTask task;
      if (!plat) {
        task = storageRef.child(uuid).putFile(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpg',
                customMetadata: {
                  'upload by': users!.userName!,
                  'description': 'Informação de arquivo',
                  'imageName': imageFile
                },
              ),
            );
      } else {
        task = storageRef.child(uuid).putData(
              imageFile,
              SettableMetadata(contentType: 'image/jpg', customMetadata: {
                'upload by': users!.userName!,
                'description': 'Informação de arquivo',
                // 'imageName': File(imageFile).
              }),
            );
      }
      //procedimento para persistir a imagem no banco de dados firebase
      String url = await (await task.whenComplete(() {})).ref.getDownloadURL();
      DocumentReference docRef = _collectionRef.doc(users!.id);
      await docRef.update({'image': url});
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
    }
  }
}
