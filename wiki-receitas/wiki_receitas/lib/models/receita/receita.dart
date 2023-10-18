import 'dart:html';

import 'package:wiki_receitas/models/receita/tipos_receita.dart';
import 'package:wiki_receitas/models/users/users.dart';

class Receita {
  int id;
  String nome;
  TiposReceita tipoReceita;
  TimeInputElement tempoDePreparo;
  Users users;
  DataElement dataCriacao;
  String modoDePreparo;

  Receita(this.id, this.nome, this.tipoReceita, this.tempoDePreparo, this.users,
      this.dataCriacao, this.modoDePreparo);

  List<Receita> getItems() {
    return [
      Receita(1, "Bolo de Cenoura", tipoReceita.getTipoBolo(),
          TimeInputElement(), users, DataElement.created(), "TEste de receita"),
      Receita(2, "Brigadeiro", tipoReceita.getTipoDoce(), TimeInputElement(),
          users, DataElement.created(), "TEste de receita"),
      Receita(3, "Sorvete", tipoReceita.getTipoGelada(), TimeInputElement(),
          users, DataElement.created(), "TEste de receita"),
    ];
  }
}
