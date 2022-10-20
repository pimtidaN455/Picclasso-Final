// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';

import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manageimage_homt.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/selectImage_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import 'ImageSliderPage.dart';

enum DialogsAction { yes, cancel }

//const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AlertDialogs_move_img {
  static Future<DialogsAction> yesMoveDialog(BuildContext context, String title,
      String body, String nameAlbum, var imageListD) async {
    DBHelper db = new DBHelper();
    var dataalbum = await db.getAlbum();
    List<String> list = [];
    print("////");
    print(dataalbum);
    print("////");
    print("เช็คคคคคค");
    var sortAlbumName = [];
    for (int i = 0; i < dataalbum.length; ++i) {
      if (dataalbum[i]['IDENTITYALBUM'] == "Usercreate") {
        sortAlbumName.add(dataalbum[i]['NAMEALBUM'] + " (Usercreate)");
      }
    }
    var allsort;
    sortAlbumName.sort();
    allsort = sortAlbumName;
    print("/////////// allsort ///////////");
    print(allsort);
    var listNameBumServer = [
      'Animals (ServerCreate)',
      'Art (ServerCreate)',
      'Cartoon (ServerCreate)',
      'Document+Education (ServerCreate)',
      'Foods (ServerCreate)',
      'Meme (ServerCreate)',
      'Object (ServerCreate)',
      'Person (ServerCreate)',
      'Place (ServerCreate)',
      'Plant (ServerCreate)',
      'Raw_Material (ServerCreate)',
      'Vehicle (ServerCreate)'
    ];
    for (int i = 0; i < allsort.length; i++) {
      list.add(allsort[i]);
    }
    //list.addAll(allsort);
    list.addAll(listNameBumServer);
    var image = imageListD;
    print("////");
    print(list);
    print("////");
    String dropdownValue = list.first;

    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: new Text("Which album do you want to move images to?"),
              content: Container(
                height: 70,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    "Confirm",
                    style: TextStyle(
                      color: MyStyle().perpleColor,
                    ),
                  ),
                  onPressed: () async {
                    manageimage_Home manage = manageimage_Home();
                    var new_nameAlbum = "";
                    if (dropdownValue.indexOf("(ServerCreate)") >= 0) {
                      new_nameAlbum = dropdownValue.substring(0,
                          (dropdownValue.length - "(ServerCreate)".length) - 1);
                    }
                    if (dropdownValue.indexOf("(Usercreate)") >= 0) {
                      new_nameAlbum = dropdownValue.substring(0,
                          (dropdownValue.length - "(Usercreate)".length) - 1);
                    }
                    await manage.move(image, nameAlbum, new_nameAlbum);
                    await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Image moved successfully.'),
                      ),
                    );
///////////////////////////////////////////////////////////////////////////+
                    var title = nameAlbum;
                    DBHelper db = DBHelper();
                    await db.deletedata_intable();
                    list_album listc = new list_album();
                    await listc.getimagefrom_api();
                    list_album listA = new list_album();

                    var showDevice = await listA.getImag_inAlbum(title);

                    var page;
                    if (showDevice['device'].length == 0 &&
                        showDevice['cloud'].length == 0) {
                      user_file user = await new user_file();
                      await user.getdata_user_file();
                      //   var user0 = await user;
                      //var ListImgCloud0;
                      var listimageshow;

                      //
                      var ListImgCloud;
                      if (await user.Login) {
                        list_album la = await new list_album();
                        await la.getimagefrom_api();
                        print(
                            'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');

                        listimageshow = await la.listimageshow;

                        listimagecloud listimgC = await new listimagecloud();
                        ListImgCloud = await listimgC.getimagefrom_api();
                        print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                        if (ListImgCloud != null && ListImgCloud.length != 0) {
                          for (int i = 0; i < ListImgCloud.length; i++) {
                            print(await ListImgCloud[i].geturlimage());
                          }
                        }
                      }
                      var ListTag = [];
                      ManageTag mnt = new ManageTag();
                      ListTag = await mnt.getTagAlbum();

                      page = FirstState(
                          page: 0,
                          user: user,
                          listimageshow: listimageshow,
                          ListImgCloud: ListImgCloud,
                          AllTagAlbum: ListTag);
                    } else {
                      page = ShowImage(
                        name: nameAlbum,
                        listimageshow: showDevice,
                      );
                    }

                    print(showDevice);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                //ShowImage(name: title, selectbum: selectbum)
                                page));
                    print("เลือกอัลบั้มที่ : ");
                    print(title);
                    print(showDevice);
                    print(
                        "///////////////////////////////////////////////////////");
                  },
                ),
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
    return (action != null) ? action : DialogsAction.cancel;
  }
}

class BackendService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));
    DBHelper db = new DBHelper();
    var dataalbum = await db.getAlbum();
    print("ดูววววววว");
    print(dataalbum);
    return List.generate(dataalbum.length, (index) {
      return dataalbum[index]["NAMEALBUM"];
    });
  }
}
