import 'package:flutter/material.dart';
import 'package:wiki_receitas/services/receita/receita.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage();

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<ReceitaService>().cart;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your cart (${cart.length})"),
      ),
      body: ListView(
        children: cart
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
  }
}
