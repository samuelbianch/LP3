import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String? email;
  String? userName;
  String? phone;
  String? birthday;
  String? password;
  String? socialMedia;

  Users({
    this.id,
    this.email,
    this.userName,
    this.phone,
    this.birthday,
    this.password,
    this.socialMedia,
  });

  //convert object to Json

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'phone': phone,
      'birthday': birthday,
      'socialMedia': socialMedia,
    };
  }

  Users.fromJson(DocumentSnapshot doc) {
    id = doc.id;
    userName = doc.get('userName');
    email = doc.get('email');
    birthday = doc.get('birthday');
    phone = doc.get('phone');
    socialMedia = doc.get('socialMedia');
  }
}
