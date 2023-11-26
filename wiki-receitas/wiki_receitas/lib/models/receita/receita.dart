import 'package:firebase_auth/firebase_auth.dart';
import 'package:wiki_receitas/models/receita/tipos_receita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Receita {
  String? id;
  String? nome;
  String? ingredientes;
  String? tipoReceita;
  String? tempoDePreparo;
  String? userID;
  DateTime? dataCriacao;
  String? modoDePreparo;
  String? imagem;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Receita(
      {this.id,
      this.nome,
      this.ingredientes,
      this.tipoReceita,
      this.tempoDePreparo,
      this.userID,
      this.dataCriacao,
      this.modoDePreparo,
      this.imagem});

  List<Receita> getItems() {
    return [
      Receita(
          id: "1",
          nome: "Bolo de Cenoura",
          ingredientes: "2 - Cenouras\n3 - Ovos",
          tipoReceita: "Bolo",
          tempoDePreparo: "69 minutos",
          userID: "1",
          dataCriacao: DateTime.now(),
          modoDePreparo: "TEste de receita"),
      Receita(
          id: "2",
          nome: "Brigadeiro",
          ingredientes: "2 - Chocolates\n3 - Ovos",
          tipoReceita: "Doce",
          tempoDePreparo: "12 minutos",
          userID: "2",
          dataCriacao: DateTime.now(),
          modoDePreparo: "TEste de receita"),
      Receita(
          id: "3",
          nome: "Sorvete",
          ingredientes: "2 - Leites\n3 - Ovos",
          tipoReceita: "Gelado",
          tempoDePreparo: "2 horas",
          userID: "3",
          dataCriacao: DateTime.now(),
          modoDePreparo: "TEste de receita"),
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeReceita': nome,
      'ingredientes': ingredientes,
      'modoPreparo': modoDePreparo,
      'tipoReceita': tipoReceita,
      'dataCriacao': dataCriacao,
      'tempoPreparo': tempoDePreparo,
      'usuarioID': auth.currentUser!.uid,
      'image': imagem,
    };
  }

  //método construtor para converter dados do objeto do tipo documento do firebase
  //em formato compatível com o Objeto Users (esta própria classe)
  Receita.fromJson(DocumentSnapshot doc) {
    id = doc.id;
    nome = doc.get('nomeReceita');
    ingredientes = doc.get('ingredientes') ?? '';
    modoDePreparo = doc.get('modoPreparo');
    tipoReceita = doc.get('tipoReceita') ?? '';
    dataCriacao = doc.get('dataCriacao') ?? '';
    tempoDePreparo = doc.get('tempoPreparo') ?? '';
    userID = doc.get('usuarioID') ?? '';
    imagem = doc.get('image') ?? '';
  }
}
