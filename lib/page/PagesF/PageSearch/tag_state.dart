import 'package:get/get.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';

class TagStateController extends GetxController {
  var listTagAdd = List<String>.empty(growable: true).obs;
  var listTagSearch = List<String>.empty(growable: true).obs;
  var listTagBum = List<String>.empty(growable: true).obs;

  check_tag_Comformable() {
    for (int i = 0; i < listTagAdd.length; i++) {
      print(listTagAdd[i].toString());
    }
  }
}

class DesScription extends GetxController {}

class ManageTag {
  getTagAlbum() async {
    DBHelper db = new DBHelper();
    List<String> AllTag = [];
    var dataAlbum = await db.getAlbum();
    if (dataAlbum.length != 0) {
      for (int i = 0; i < dataAlbum.length; i++) {
        if (dataAlbum[i]["KEYWORDALBUM"].length != 0 &&
            dataAlbum[i]["KEYWORDALBUM"] != null &&
            dataAlbum[i]["IDENTITYALBUM"] == "Usercreate") {
          String kw = "";
          print(dataAlbum[i]["KEYWORDALBUM"]);
          for (int j = 0; j < dataAlbum[i]["KEYWORDALBUM"].length; j++) {
            if (dataAlbum[i]["KEYWORDALBUM"][j] != "/") {
              print(dataAlbum[i]["KEYWORDALBUM"][j]);
              kw += dataAlbum[i]["KEYWORDALBUM"][j];
            } else if (dataAlbum[i]["KEYWORDALBUM"][j] == "/") {
              print(kw);
              if (AllTag.contains(kw) != true) {
                AllTag.add(kw);
              }
              kw = "";
            }
          }
        }
      }
    }

    return AllTag;
  }
}
