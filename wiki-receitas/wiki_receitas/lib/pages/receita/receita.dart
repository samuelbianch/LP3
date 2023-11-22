import 'package:flutter/material.dart';
import 'package:wiki_receitas/models/receita/receita.dart';
import 'package:wiki_receitas/services/receita/receita.dart';
import 'package:provider/provider.dart';

class ReceitaPage extends StatefulWidget {
  ReceitaPage({super.key});

  @override
  State<ReceitaPage> createState() => _ReceitaPage();
}

class _ReceitaPage extends State<ReceitaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receitas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Consumer<ReceitaService>(
          builder: (context, value, child) {
            return Container(
              child: ListView(
                children: value.cart
                    .map(
                      (e) => ListTile(
                        title: Text(e.nome ?? ''),
                        subtitle: Text("USD " + (e.modoDePreparo ?? '')),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            context.read<ReceitaService>().removeFromCart(e);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
