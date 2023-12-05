import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/services/receita/receita.dart';

class MinhasReceitasPage extends StatelessWidget {
  const MinhasReceitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    ReceitaService receitaService = ReceitaService();
    return Scaffold(
      appBar: AppBar(title: const Text("Minhas Receitas"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            StreamBuilder(
                stream: receitaService.getAllReceitas(),
                builder: (contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnapshot =
                            snapshot.data!.docs[index];
                        if (docSnapshot['usuarioID'] == auth.currentUser!.uid) {
                          return Card(
                            color: Colors.white,
                            child: InkWell(
                              // onTap: () {}=> Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ReceitaPage())),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          docSnapshot['image'] ??
                                              "assets/images/receita.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    ],
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.food_bank),
                                    title: Text(docSnapshot['nomeReceita']),
                                    subtitle: Text(
                                      docSnapshot['modoPreparo'].length > 50
                                          ? docSnapshot['modoPreparo']
                                                  .substring(0, 50) +
                                              '...'
                                          : docSnapshot['modoPreparo'],
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            FirebaseFirestore firestore =
                                                FirebaseFirestore.instance;
                                            firestore
                                                .collection('receitas')
                                                .doc(docSnapshot.id)
                                                .delete();
                                          },
                                          child: const Icon(Icons.delete,
                                              color: Colors.red),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            //Navigator.push(context)
                                          },
                                          child: const Icon(Icons.edit,
                                              color: Colors.blue),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                      },
                    );
                  } else {
                    return const Text("Usuario sem receita cadastrada");
                  }
                })
          ],
        ),
      ),
    );
  }
}
