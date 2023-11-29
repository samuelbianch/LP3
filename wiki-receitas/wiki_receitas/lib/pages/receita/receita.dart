import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/services/receita/receita.dart';
import 'package:provider/provider.dart';

class ReceitaPage extends StatelessWidget {
  ReceitaPage({super.key});
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var receitas = context
        .watch<ReceitaService>()
        .getReceitasByUserID(_firebaseAuth.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receitas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Consumer<ReceitaService>(
          builder: (context, receitaService, child) {
            return Text(receitas.first.toString());
          },
        ),
      ),
    );
  }
}
