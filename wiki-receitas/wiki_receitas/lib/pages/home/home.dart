import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wiki_receitas/login/login.dart';
import 'package:wiki_receitas/pages/receita/receita.dart';
import 'package:wiki_receitas/pages/userprofile/userprofile.dart';
import 'package:wiki_receitas/services/receita/receita.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.white,
          child: InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReceitaPage())),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        '/images/receita.png',
                        height: MediaQuery.of(context).size.width * .6,
                        width: MediaQuery.of(context).size.width * .95,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                const ListTile(
                  leading: Icon(Icons.food_bank),
                  title: Text('Título da receita'),
                  subtitle: Text('Aqui uma breve descrição'),
                ),
                const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Feito por: Samuel Bianch'),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
