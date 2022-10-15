class ClassAlbum {
  late String idAlbum;
  late String nameAlbum;
  late String keywordAlbum;
  ClassAlbum(this.idAlbum, this.nameAlbum, this.keywordAlbum);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'idAlbum': idAlbum,
      'nameAlbum': nameAlbum,
      'keywordAlbum': keywordAlbum,
    };
    return map;
  }

  ClassAlbum.fromMap(dynamic map, bool bool) {
    idAlbum = map['idAlbum'];
    nameAlbum = map['nameAlbum'];
    keywordAlbum = map['keywordAlbum'];
  }
}
