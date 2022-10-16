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
    for (int i = 0; i < dataalbum.length; ++i) {
      list.add(dataalbum[i]['NAMEALBUM']);
      /*  " (" +
          dataalbum[i]['IDENTITYALBUM'] +
          ") ");*/
    }
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
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
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
                      color: MyStyle().perpleColorSawang,
                    ),
                  ),
                  onPressed: () async {
                    manageimage_Home manage = manageimage_Home();
                    await manage.move(image, nameAlbum, dropdownValue);
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
                    /* List<ImageData> imageListD = [];
                    List<ImageData> imageListC = [];

                    DBHelper db = DBHelper();
                    await db.deletedata_intable();
                    list_album listc = new list_album();
                    await listc.getimagefrom_api();
                    list_album listA = new list_album();
                    var imagelist = [];
                    var showDevice = await listA.getImag_inAlbum(title);
                    print(showDevice);
                    //imageList = ImageData.getImage();
                    for (int i = 0; i < showDevice["device"].length; i++) {
                      ImageData idt = ImageData(
                          showDevice["device"][i]['img'] as String,
                          false,
                          i,
                          showDevice["device"][i]['nameimg']);
                      imagelist.add(idt);
                    }
                    //var lenListD = imageListD.length;
                    print(imagelist.length);
                    print("******00*****");
                    for (int i = 0; i < showDevice["cloud"].length; i++) {
                      ImageData idtc = ImageData(
                          showDevice["cloud"][i]['img'] as String,
                          false,
                          i,
                          showDevice["cloud"][i]['nameimg']);
                      imagelist.add(idtc);
                    }
                    var lenListC = showDevice["cloud"].length;
                    var lenListD = showDevice["device"].length;
                    String statusitem = "Don't have";
                    if (lenListC != 0 && lenListD != 0) {
                      statusitem = "Have 2";
                    } else if (lenListC != 0 && lenListD == 0) {
                      statusitem = "Have 1 Cloud";
                    } else if (lenListC == 0 && lenListD != 0) {
                      statusitem = "Have 1 Device";
                    }
                    print(imagelist.length);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectImageHomePage(
                                  imageListD: imagelist,
                                  lenListC: lenListC,
                                  iconselect: "move",
                                  statusitem: statusitem,
                                  title: nameAlbum,
                                  /*iconselect: "delete"*/
                                  /*iconselect: "delete"*/
                                )));*/
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
