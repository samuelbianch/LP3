import 'package:flutter/material.dart';
import 'package:wiki_receitas/models/receita/receita.dart';

class ReceitaService with ChangeNotifier {
  Receita? receita;

  late final List<Receita> _items = getItems();
  final List<Receita> _cart = [];

  List<Receita> get items => _items;

  List<Receita> get cart => _cart;

  void addToCart(Receita item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Receita item) {
    _cart.remove(item);
    notifyListeners();
  }

  List<Receita> getItems() {
    return receita!.getItems();
  }
}
