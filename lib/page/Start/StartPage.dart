// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/howtouse.dart';
import 'package:project_photo_learn/page/Start/start_login.dart';

class Start_page extends StatefulWidget {
  const Start_page({Key? key}) : super(key: key);
  @override
  _Start_pageState createState() => _Start_pageState();
}

class _Start_pageState extends State<Start_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: MyStyle().whiteColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 200),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                    child: Image.asset(
                      'images/logo2.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'PICCLASSO',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: MyStyle().blackColor,
                      fontSize: 35,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: ShowButton(),
                        ),
                      ],
                    ),
                  ),
                ])
          ],
        ),
      ),
    )));
  }

  Widget ShowButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        PermissionButton(),
        SizedBox(
          width: 20.0,
        ),
        StartButton(),
        HowtoButtonn(),
      ],
    );
  }

  Widget StartButton() {
    return RaisedButton(
      color: MyStyle().perpleColor,
      child: Text(
        'Login',
        style: TextStyle(
          color: MyStyle().whiteColor,
          fontSize: 20,
        ),
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Startlogin());

        Navigator.of(this.context).push(materialPageRoute);
      },
    );
  }

  Widget PermissionButton() {
    return FlatButton(
      child: Text(
        'Permission',
        style: TextStyle(
          color: MyStyle().whiteColor,
          fontSize: 20,
        ),
      ),
      color: MyStyle().deleteColor,
      onPressed: () async {
        bool req = await Permission.storage.request().isGranted;
        print(req);
      },
    );
  }

  Widget HowtoButtonn() {
    return RaisedButton(
      color: MyStyle().whiteColor,
      child: Text(
        'How to use',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      onPressed: () {
        //print('fuckkkkkkkkkkkkkkkkkkkk');

        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => HowToUse2(pagehow: "startpage"));
        Navigator.of(this.context).push(materialPageRoute);
      },
    );
  }
}
