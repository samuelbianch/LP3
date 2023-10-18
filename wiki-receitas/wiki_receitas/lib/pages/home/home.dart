import 'package:flutter/material.dart';
//import 'package:wiki_receitas/pages/receita/receita.dart';
//import 'package:wiki_receitas/services/receita/receita.dart';
//import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    //var items = context.watch<ReceitaService>().items;
    //var cart = context.watch<ReceitaService>().cart;
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
    );
  }
}
