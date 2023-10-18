import 'package:flutter/material.dart';
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
        title: const Text("Flutter Ecom"),
      ),
      body: [
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Página inicial")],
          ),
        ),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Carrinho de Compras'),
            ],
          ),
        ),
        Center(
          child: Container(
            color: Colors.orange,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Galeria de Produtos'),
              ],
            ),
          ),
        ),
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
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho',
            ),
            NavigationDestination(
              icon: Icon(Icons.line_style_outlined),
              label: 'Pedidos',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_box_outlined),
              label: 'Perfil de Usuário',
            )
          ]),
    );
  }
}
