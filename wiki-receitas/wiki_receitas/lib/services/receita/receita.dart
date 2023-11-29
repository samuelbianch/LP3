import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wiki_receitas/models/receita/receita.dart';

class ReceitaService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Receita? receita;
  DocumentReference get _firestoreRef =>
      _firestore.doc('receitas/${const Uuid().v1()}');
  CollectionReference get _collectionRef => _firestore.collection('receitas');

  late final List<Receita> _items = getItems();
  final List<Receita> _cart = [];

  List<Receita> get items => _items;

  ReceitaService();

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
    notifyListeners();
    return receita!.getItems();
  }

  Future<bool> create(Receita receitas) async {
    try {
      await _firestoreRef.set(receitas.toJson());
      notifyListeners();
      return Future.value(true);
    } on FirebaseException catch (error) {
      debugPrint(error.message);
      return Future.value(false);
    }
  }

  Future<Receita> getReceitaById(String id) async {
    try {
      DocumentSnapshot docReceita =
          await _firestore.collection('receitas').doc(id).get();
      notifyListeners();
      return Future.value(Receita.fromJson(docReceita));
    } on FirebaseException catch (error) {
      debugPrint("Erro ao buscar receita pelo ID: ${error.message}");
      throw ();
    }
  }

  Future<Stream<List<Receita>>> getReceitas() async {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> snaphot =
          _firestore.collection('receitas').snapshots();

      Stream<List<Receita>> dataStream = snaphot.map(
          (list) => list.docs.map((doc) => Receita.fromJson(doc)).toList());
      notifyListeners();
      return Future.value(dataStream);
    } on FirebaseException catch (error) {
      debugPrint("Erro ao buscar receitas: ${error.message}");
      throw ();
    }
  }

  Stream<List<Receita>> getReceitasByUserID(String userID) {
    try {
      var receitas = _firestore
          .collection('receitas')
          .where('userID', isEqualTo: userID)
          .snapshots();

      Stream<List<Receita>> listaReceita = receitas.map((event) =>
          event.docs.map((receita) => Receita.fromJson(receita)).toList());
      notifyListeners();
      return listaReceita;
    } on FirebaseException catch (error) {
      debugPrint("Erro ao buscar receitas: ${error.message}");
      throw ();
    }
  }
}
