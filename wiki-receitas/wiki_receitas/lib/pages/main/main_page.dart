import 'package:flutter/material.dart';
import 'package:wiki_receitas/pages/home/home.dart';
import 'package:wiki_receitas/pages/receita/minhas_receitas.dart';
import 'package:wiki_receitas/pages/receita_favorita/receitas_favoritas.dart';
import 'package:wiki_receitas/pages/userprofile/userprofile.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ,
        elevation: 2.0,
        title: const Text("Wiki Receitas"),
      ),
      body: [
        const HomePage(),
        ReceitasFavoritasPage(),
        MinhasReceitasPage(),
        const UserProfilePage(),
      ][_index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (int position) {
            setState(() {
              _index = position;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Receitas Favoritas',
            ),
            NavigationDestination(
              icon: Icon(Icons.food_bank_outlined),
              label: 'Minhas Receitas',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_box_outlined),
              label: 'Perfil de Usuário',
            )
          ]),
    );
  }
}
