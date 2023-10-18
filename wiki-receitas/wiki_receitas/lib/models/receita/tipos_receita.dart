class TiposReceita {
  int id;
  String descricao;

  TiposReceita(this.id, this.descricao);

  TiposReceita getTipoDoce() {
    return TiposReceita(1, "Doces");
  }

  TiposReceita getTipoGelada() {
    return TiposReceita(2, "Geladas");
  }

  TiposReceita getTipoBolo() {
    return TiposReceita(3, "Bolos");
  }
}
