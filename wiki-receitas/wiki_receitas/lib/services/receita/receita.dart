import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/models/receita/receita.dart';

class ReceitaService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Receita? receita;
  DocumentReference get _firestoreRef =>
      _firestore.doc('receitas/${_auth.currentUser!.uid}');
  CollectionReference get _collectionRef => _firestore.collection('receitas');

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

  Future<bool> create(Receita receitas) async {
    try {
      await _firestoreRef.set(receitas.toJson());
      return Future.value(true);
    } on FirebaseException catch (error) {
      debugPrint(error.message);
      return Future.value(false);
    }
  }
}
