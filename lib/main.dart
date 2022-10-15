// ignore_for_file: invalid_language_version_override

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
//import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';
import 'package:project_photo_learn/page/Start/StartPage.dart';
//@dart=2.9

void main() async {
  // ignore: deprecated_member_use
  /*FlatButton(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text('Grant Request'),
    ),
    color: Colors.blue,
    onPressed: () async {
      bool req = await Permission.storage.request().isGranted;
      print(req);
    },
  );*/
  WidgetsFlutterBinding.ensureInitialized();
  user_file user = await new user_file();
  // print("DDDDDDDDDDDDDDDDDDDDDDDDDD");
  await user.getdata_user_file();
  print(await user.Firstname);
  print("DDDDDDDDDDDDDDDDDD");
  var ListImgCloud;
  var listimageshow;
  var ListTag = [];

  if (await user.Login) {
    print(await user.Login);
    print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
    list_album la = await new list_album();
    await la.getimagefrom_api();
    print(
        'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
    listimageshow = await la.listimageshow;

    listimagecloud listimgC = await new listimagecloud();
    ListImgCloud = await listimgC.getimagefrom_api();

    ManageTag mnt = new ManageTag();
    ListTag = await mnt.getTagAlbum();
  }
  print("ลิสอิมเมดโชวววว์");
  print(listimageshow);

  runApp(MyApp(
      user: await user,
      listimageshow: listimageshow,
      ListImgCloud: await ListImgCloud,
      AllTagAlbum: await ListTag));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  var user;
  var listimageshow;
  var ListImgCloud;
  var AllTagAlbum;
  MyApp(
      {required this.user,
      required this.listimageshow,
      required this.ListImgCloud,
      required this.AllTagAlbum});
  @override
  State<MyApp> createState() => _MyAppState(
      user: this.user,
      listimageshow: this.listimageshow,
      ListImgCloud: this.ListImgCloud,
      AllTagAlbum: this.AllTagAlbum);
}

class _MyAppState extends State<MyApp> {
  var user;
  var listimageshow;
  var ListImgCloud;
  var AllTagAlbum;
  _MyAppState(
      {required this.user,
      required this.listimageshow,
      required this.ListImgCloud,
      required this.AllTagAlbum});

  get home => null;
  @override
  Widget build(BuildContext context) {
    //////////////////////////// รับสถานะเช็ค ///////////////////////////
    //bool i = true;
    var page_material;
    print("---------------AAAAAAA--------------");
    print(listimageshow);
    // print(ListImgCloud[0].gettoString());
    //print(ListImgCloud[0].geturlimage());
    if (user.Login) {
      //if (i) {
      print("jj");
      page_material = FirstState(
          page: 0,
          user: user,
          listimageshow: listimageshow,
          ListImgCloud: ListImgCloud,
          AllTagAlbum: AllTagAlbum);
    } else {
      page_material = Start_page();
    }

    /* 
*/
    return MaterialApp(
      home: page_material,
    );
  }
}
