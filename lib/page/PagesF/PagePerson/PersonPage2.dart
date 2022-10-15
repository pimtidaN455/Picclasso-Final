// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/howtouse.dart';
import 'package:project_photo_learn/page/PagesF/PagePerson/alrert_dialog.dart';
import 'package:project_photo_learn/page/PagesF/PagePerson/setting_page.dart';
import 'package:project_photo_learn/re_password.dart';

class Person_page1 extends StatefulWidget {
  var user;
  Person_page1({required this.user});
  @override
  _Start_pageState createState() => _Start_pageState(user: user);
}

class _Start_pageState extends State<Person_page1> {
  var user;
  _Start_pageState({required this.user});

  String title = 'AlertDialog';
  bool tappedYes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: NameAndMail(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: MyStyle().blackColor,
      title: Text(
        "Profile",
        style: TextStyle(
          fontSize: 30,
          color: MyStyle().whiteColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Rajdhani',
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Container NameAndMail() {
    Size size = MediaQuery.of(context).size;
    return Container(
      //padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 10),
      height: size.height * 1,

      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 56),
            height: size.height * 0.2 - 60,
            decoration: BoxDecoration(
              color: MyStyle().blackColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
            ),
          ),
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Text(
                  "\n" + user.Firstname + ' ' + user.Lastname,
                  style: TextStyle(
                    color: MyStyle().whiteColor,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.Email,
                  style: TextStyle(
                    color: MyStyle().whiteColor,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ///////////// How to ///////////////
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: MyStyle().grayColor,
                    onPressed: () {
                      MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HowToUse2(pagehow: "personpage"));
                      Navigator.of(this.context).push(materialPageRoute);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 20),
                        Expanded(
                            child: Text(
                          "How to use",
                          style: TextStyle(
                            color: MyStyle().darkColor,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        )),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),
                ///////////// Setting ///////////////
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: MyStyle().grayColor,
                    onPressed: () {
                      MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              setting_page(user: user));
                      Navigator.of(this.context).push(materialPageRoute);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 20),
                        Expanded(
                            child: Text(
                          "Setting",
                          style: TextStyle(
                            color: MyStyle().darkColor,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        )),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),

                ///////////// Logout ///////////////
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: RaisedButton(
                    onPressed: () async {
                      final action = await AlertDialogs.yesCancelDialog(
                          context, 'Log out', 'Are you sure?');
                      if (action == DialogsAction.yes) {
                        setState(() => tappedYes = true);
                      } else {
                        setState(() => tappedYes = false);
                      }
                    },
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: MyStyle().grayColor,
                    child: Row(
                      children: [
                        Icon(Icons.key),
                        SizedBox(width: 20),
                        Expanded(
                            child: Text(
                          "Log out",
                          style: TextStyle(
                            color: MyStyle().darkColor,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        )),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
