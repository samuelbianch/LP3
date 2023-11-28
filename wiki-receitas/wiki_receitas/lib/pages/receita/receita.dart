import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/models/receita/receita.dart';
import 'package:wiki_receitas/services/receita/receita.dart';
import 'package:provider/provider.dart';
import 'package:wiki_receitas/services/users/users_services.dart';

class ReceitaPage extends StatefulWidget {
  ReceitaPage({super.key});

  @override
  State<ReceitaPage> createState() => _ReceitaPage();
}

class _ReceitaPage extends State<ReceitaPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receitas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Consumer<ReceitaService>(
          builder: (context, receitaService, child) {
            return Container(
              child: ListView(
                  children: receitaService
                      .getReceitasByUserID(_firebaseAuth.currentUser!.uid)
                      .forEach((element) {
                      element.map((e) {
                        Text(e.nome)
                      },)
                      })),
            );
          },
        ),
      ),
    );
  }
}
