class Photo {
  late String id;
  late String photoName;
  late String photopath;
  late var photokeyword;
  late var photodescriptions;
  late String photoclass;
  late String fixalbum;
  late String statuscloud;
  late String Cloud_Storage;
  Photo(
      this.id,
      this.photoName,
      this.photopath,
      this.photokeyword,
      this.photodescriptions,
      this.fixalbum,
      this.statuscloud,
      this.photoclass,
      this.Cloud_Storage);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photoName': photoName,
      'photopath': photopath,
      'photokeyword': photokeyword,
      'photodescriptions': photodescriptions,
      'fixalbum': fixalbum,
      'statuscloud': statuscloud,
      'photoclass': photoclass,
      'Cloud_Storage': Cloud_Storage,
    };
    return map;
  }

  Photo.fromMap(dynamic map, bool bool) {
    id = map['id'];
    photoName = map['photoName'];
    photopath = map['photopath'];
    photokeyword = map['photokeyword'];
    photodescriptions = map['photodescriptions'];
    fixalbum = map['fixalbum'];
    statuscloud = map['statuscloud'];
    photoclass = map['photoclass'];
    Cloud_Storage = map['Cloud_Storage'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return photopath;
  }
}
