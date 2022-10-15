// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';

import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';

class setting_Album_server extends StatefulWidget {
  var title;
  setting_Album_server({required this.title});
  @override
  _Start_pageState createState() => _Start_pageState(title: this.title);
}

class _Start_pageState extends State<setting_Album_server> {
  var title;
  _Start_pageState({required this.title});

  //String title = 'AlertDialog';
  bool tappedYes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: setting_P(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: MyStyle().whiteColor,
        ),
        onPressed: () async {
          var title = this.title;
          DBHelper db = DBHelper();
          await db.deletedata_intable();
          list_album listc = new list_album();
          await listc.getimagefrom_api();
          list_album listA = new list_album();

          var showDevice = await listA.getImag_inAlbum(title);
          print(showDevice);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      //ShowImage(name: title, selectbum: selectbum)
                      ShowImage(
                        name: title,
                        listimageshow: showDevice,
                      )));
        },
      ),
      backgroundColor: MyStyle().blackColor,
      title: Text(
        "Setting Album",
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

  Container setting_P() {
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
                  height: 50,
                ),
                Text(
                  this.title,
                  style: TextStyle(
                    color: MyStyle().whiteColor,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ///////////// How to ///////////////

                ///////////// Setting ///////////////

                ///////////// Logout ///////////////
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: RaisedButton(
                    onPressed: () async {},
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
                          "Delete",
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
