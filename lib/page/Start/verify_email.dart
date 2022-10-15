// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/page/Backend/Check_User.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';
import 'package:project_photo_learn/page/Start/StartPage.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs_verified_email {
  static Future<DialogsAction> yesCancelDialog(
      BuildContext context, var tokenUser) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text("Verified email"),
          content:
              Text("Would you like to receive a confirmation email again?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Text(
                'No',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              //onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
              onPressed: () async {
                await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        "The system send a confirmation email to your email address."),
                  ),
                );

                use_API api = new use_API();
                await api.getverify_email(tokenUser);

                Navigator.of(context).pop(DialogsAction.yes);
              },
              child: Text(
                'Yes',
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
