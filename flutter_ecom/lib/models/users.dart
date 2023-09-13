import 'dart:js';

class Users{
  String? id;
  String? email;
  String? userName;
  String? phone;
  String? birthday;
  String? password;

  Users({
    this.id,
    this.email,
    this.userName,
    this.phone,
    this.birthday,
    this.password,
  });

  //convert object to Json

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'phone': phone,
      'birthday': birthday,
    };
  }
}