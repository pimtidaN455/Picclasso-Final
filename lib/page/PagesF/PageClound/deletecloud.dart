// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/page/Backend/Check_User.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';
import 'package:project_photo_learn/page/Start/StartPage.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs_delete_cloud {
  static Future<DialogsAction> yesCancelDialog(
      BuildContext context, String title, String body, var img) async {
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
              //onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
              onPressed: () async {
                manage_imagecloud manage = manage_imagecloud();
                await manage.delete_imagecloud(img);

                DBHelper db = DBHelper();
                await db.deletedata_intable();
                user_file user = await new user_file();
                await user.getdata_user_file();
                var user0 = await user;
                var ListImgCloud;
                var listimageshow;

                //

                if (await user.Login) {
                  list_album la = await new list_album();
                  await la.getimagefrom_api();
                  print(
                      'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                  listimageshow = await la.listimageshow;

                  listimagecloud listimgC = await new listimagecloud();
                  ListImgCloud = await listimgC.getimagefrom_api();
                  print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                  /*for (int i = 0; i < ListImgCloud.length; i++) {
                      print(await ListImgCloud[i].geturlimage());
                    }*/
                }
                var ListTag = [];
                ManageTag mnt = new ManageTag();
                ListTag = await mnt.getTagAlbum();
                await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Delete image successfully.'),
                  ),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstState(
                            page: 2,
                            user: user,
                            listimageshow: listimageshow,
                            ListImgCloud: ListImgCloud,
                            AllTagAlbum: ListTag)));
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
