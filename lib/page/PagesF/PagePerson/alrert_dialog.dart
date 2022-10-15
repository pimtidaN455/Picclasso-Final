// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/page/Backend/Check_User.dart';
import 'package:project_photo_learn/page/Start/StartPage.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
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
                check_user chuse = new check_user();
                DBHelper db = DBHelper();
                await db.deletedata_intable();
                chuse.logout();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Start_page()));
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
