import 'dart:html';

import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text("Página Inicial"),
      ),
      body: SafeArea(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: const Text("Bianch Receitas"),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          debugPrint('Valor: $value');
          if (value == 0) Navigator.of(context).pushNamed('/home');
          if (value == 1) Navigator.of(context).pushNamed('/receitas');
          if (value == 2) Navigator.of(context).pushNamed('/userprofile');
          if (value == 3) Navigator.of(context).pushNamed('/login');
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Receitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sign_language),
            label: 'Entrar',
          ),
        ],
        currentIndex: selectedIndex,
        //onTap: _onItemTapped,
        selectedItemColor: Colors.red,
      ),
    );
  }
}
