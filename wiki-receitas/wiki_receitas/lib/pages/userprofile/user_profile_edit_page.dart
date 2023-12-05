import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/models/users/users.dart';
import 'package:wiki_receitas/pages/userprofile/userprofile.dart';
import 'package:wiki_receitas/services/users/users_services.dart';
import 'package:provider/provider.dart';

class UserProfileEditPage extends StatelessWidget {
  UserProfileEditPage({this.users});
  final Users? users;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _collectionRef = _firestore.collection('users');
    final TextEditingController userName = TextEditingController();
    final TextEditingController telefone = TextEditingController();
    final TextEditingController socialMedia = TextEditingController();
    final TextEditingController dataNascimento = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Consumer<UsersServices>(
          builder: (context, usersServices, _) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Editando Perfil de Usuário",
                  style: TextStyle(
                    color: Color.fromARGB(255, 2, 32, 3),
                    fontSize: 28,
                    fontFamily: 'Lustria',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ClipOval(
                  child: Image.network(
                    usersServices.users!.image!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  //initialValue: usersServices.users!.userName!,
                  controller: userName,
                  decoration: InputDecoration(
                    label: const Text('Nome do Usuário'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  //initialValue: usersServices.users!.phone!,
                  controller: telefone,
                  decoration: InputDecoration(
                    label: const Text('Telefone'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  //initialValue: usersServices.users!.socialMedia!,
                  controller: socialMedia,
                  decoration: InputDecoration(
                    label: const Text('Rede Social'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  //initialValue: usersServices.users!.birthday!,
                  controller: dataNascimento,
                  decoration: InputDecoration(
                    label: const Text('Data de Nascimento'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    DocumentReference docRef =
                        _collectionRef.doc(usersServices.users!.id);
                    FirebaseAuth auth = FirebaseAuth.instance;
                    await docRef.update({
                      'userName': userName.text,
                      'phone': telefone.text,
                      'birthday': dataNascimento.text,
                      'socialMedia': socialMedia.text,
                    });
                    await auth.currentUser?.updateDisplayName(userName.text);
                    const UserProfilePage();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
