import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/pages/receita/receita.dart';
import 'package:wiki_receitas/services/receita/receita.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    ReceitaService receitaService = ReceitaService();
    return Scaffold(
      appBar: AppBar(title: const Text("Receitas"), centerTitle: true),
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
                        return Card(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReceitaPage())),
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
                                            "assets/images/receita.png", //docSnapshot['image']!,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  ],
                                ),
                                ListTile(
                                  leading: const Icon(Icons.food_bank),
                                  title: Text(docSnapshot['nomeReceita']!),
                                  subtitle: Text(
                                    docSnapshot['modoPreparo']!.length > 50
                                        ? docSnapshot['modoPreparo']!
                                                .substring(0, 50) +
                                            '...'
                                        : docSnapshot['modoPreparo']!,
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          "Feito por: ${auth.currentUser!.displayName!}"),
                                    ]),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("ERRO AO CARREGAR DADOS");
                  }
                })
          ],
        ),
      ),
    );
  }
}
