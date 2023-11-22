import 'dart:ffi';
import 'dart:html';

import 'package:wiki_receitas/models/receita/tipos_receita.dart';
import 'package:wiki_receitas/models/users/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Receita {
  int? id;
  String? nome;
  String? ingredientes;
  TiposReceita? tipoReceita;
  String? tempoDePreparo;
  Users? users;
  DateTime? dataCriacao;
  String? modoDePreparo;
  String? imagem;

  Receita(
      {this.id,
      this.nome,
      this.ingredientes,
      this.tipoReceita,
      this.tempoDePreparo,
      this.users,
      this.dataCriacao,
      this.modoDePreparo});

  List<Receita> getItems() {
    return [
      Receita(
          1,
          "Bolo de Cenoura",
          "2 - Cenouras\n3 - Ovos",
          tipoReceita!.getTipoBolo(),
          "69 minutos",
          users,
          DateTime.now(),
          "TEste de receita"),
      Receita(
          id: 2,
          nome: "Brigadeiro",
          ingredientes: "2 - Chocolates\n3 - Ovos",
          tipoReceita!.getTipoDoce(),
          "12 minutos",
          users,
          DateTime.now(),
          "TEste de receita"),
      Receita(
          3,
          "Sorvete",
          "2 - Leites\n3 - Ovos",
          tipoReceita!.getTipoGelada(),
          "2 horas",
          users,
          DateTime.now(),
          "TEste de receita"),
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
      'usuarioID': users.id,
      'image': imagem,
    };
  }

  //método construtor para converter dados do objeto do tipo documento do firebase
  //em formato compatível com o Objeto Users (esta própria classe)
  Receita.fromJson(DocumentSnapshot doc) {
    id = int.parse(doc.id);
    nome = doc.get('nomeReceita');
    ingredientes = doc.get('ingredientes') ?? '';
    modoDePreparo = doc.get('modoPreparo');
    tipoReceita = doc.get('tipoReceita') ?? '';
    dataCriacao = doc.get('dataCriacao') ?? '';
    tempoDePreparo = doc.get('tempoPreparo') ?? '';
    users = doc.get('usuarioID') ?? '';
    imagem = doc.get('image') ?? '';
  }
}
