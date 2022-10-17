// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';

import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Delete_Albums.dart';

import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manageimage_homt.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_client.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs_manage_album {
  static Future<DialogsAction> yesCancelDialog(
      BuildContext context,
      String title,
      String body,
      String nameAlbum,
      String status,
      var datamanage_album,
      String cheack) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                var page;
                use_API api = new use_API();
                print("**********//////////////////*******************");

                if (status == "delete") {
                  api.manage_Album(nameAlbum, "", "", "", status);
                  user_file user0 = new user_file();
                  await user0.getdata_user_file();
                  var user = await user0;

                  var ListImgCloud;
                  var listimageshow;
                  if (await user.Login) {
                    list_album la = new list_album();
                    var ListImageDevice = await la.getimagefrom_api();
                    print(
                        'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                    //print(await la.listimageshow_device);
                    listimageshow = await la.listimageshow;

                    listimagecloud listimgC = new listimagecloud();
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
                  print("เช็ค cheack");
                  print(cheack);
                  if (cheack == "Select_Delete") {
                    print("เช็ค cheack อีกที");
                    print(cheack);
                    user_file user0 = new user_file();
                    await user0.getdata_user_file();
                    var user = await user0;

                    var ListImgCloudfor_delete;
                    var listimagefor_delete;
                    if (await user.Login) {
                      list_album la = new list_album();

                      await la.getimagefrom_api_No_Cloud();
                      print(
                          'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                      //print(await la.listimageshow_device);
                      listimagefor_delete = await la.listimageshow;

                      listimagecloud listimgC = new listimagecloud();
                      ListImgCloud = await listimgC.getimagefrom_api();
                      print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                    }
                    var ListTag = [];
                    ManageTag mnt = new ManageTag();
                    ListTag = await mnt.getTagAlbum();

                    page = DeleteAlbums(
                        user: user,
                        listimageshow: listimagefor_delete,
                        ListImgCloud: ListImgCloud);
                  } else {
                    page = FirstState(
                        page: 0,
                        user: user,
                        listimageshow: listimageshow,
                        ListImgCloud: ListImgCloud,
                        AllTagAlbum: ListTag);
                  }
                }
                if (status == "update") {
                  await api.manage_Album(
                      datamanage_album["namealbum"],
                      datamanage_album["nameoldalbum"],
                      datamanage_album["keyword"],
                      datamanage_album["description"],
                      status);
                  DBHelper db = DBHelper();
                  await db.deletedata_intable();
                  list_album listc = new list_album();
                  await listc.getimagefrom_api();
                  DBHelper db2 = DBHelper();
                  var dataalbum =
                      await db2.getData_Album(datamanage_album["namealbum"]);

                  print("*******////555///*****");
                  print(await dataalbum);
                  print("*******////*****");
                  print(dataalbum[0]['IDENTITYALBUM']);

                  var description = "";
                  var keyword = "";
                  if (dataalbum[0]['DESCRIPTIONALBUM'].length != 0) {
                    description = dataalbum[0]['DESCRIPTIONALBUM'];
                  }
                  if (dataalbum[0]['KEYWORDALBUM'].length != 0) {
                    //keyword = dataalbum[0]['KEYWORDALBUM'];
                    for (int i = 0;
                        i < dataalbum[0]['KEYWORDALBUM'].length;
                        ++i) {
                      if (dataalbum[0]['KEYWORDALBUM'][i] == "/" &&
                          i < dataalbum[0]['KEYWORDALBUM'].length - 1) {
                        keyword += " , ";
                      } else if (dataalbum[0]['KEYWORDALBUM'][i] != "/") {
                        keyword += dataalbum[0]['KEYWORDALBUM'][i];
                      }
                    }
                  }
                  list_album listA = new list_album();
                  var showDevice = await listA.getImag_inAlbum(title);
                  print("showwwwwwwwwwwwwwwwwwwwwwwwwww");
                  print(showDevice);
                  print("showwwwwwwwwwwwwwwwwwwwwwwwwww");
                  print(description);
                  print(keyword);
                  await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Update Success'),
                    ),
                  );

                  page = await ShowImage(
                      name: datamanage_album["namealbum"],
                      listimageshow: showDevice,
                      statusAlbum: "Usercreate");
                }

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => page));
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                    color: Color(0xFFC41A3B), fontWeight: FontWeight.w700),
              ),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }
}
