// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Edit_keyword_des.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manage_album_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/renameAlbum.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

// ignore: must_be_immutable
class setting_Album_Client extends StatefulWidget {
  var title;
  var description;
  var keyword;
  setting_Album_Client(
      {required this.title, required this.description, required this.keyword});

  @override
  setting_album_page createState() => setting_album_page(
      title: this.title, description: this.description, keyword: this.keyword);
}

class setting_album_page extends State<setting_Album_Client> {
  var title;
  var description;
  var keyword;
  // ignore: must_be_immutable
  setting_album_page(
      {required this.title, required this.description, required this.keyword});

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
          color: MyStyle().blackColor,
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
                          statusAlbum: "Usercreate")));
        },
      ),
      ////////////////////////////////////////////
      backgroundColor: MyStyle().whiteColor,
      title: Text(
        "Album details : " + this.title,
        style: TextStyle(
          fontSize: 23,
          color: MyStyle().blackColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Rajdhani',
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  SingleChildScrollView setting_P() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            //ชื่ออัลบั้ม
            "   Name Album : " + this.title,
            style: TextStyle(
              color: MyStyle().blackColor,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            //เดสทั้งหมดของอลับั้มนั้น
            "   Description : " + description,
            style: TextStyle(
              color: MyStyle().blackColor,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            //เดสทั้งหมดของอลับั้มนั้น
            "   Keyword : ",
            style: TextStyle(
              color: MyStyle().blackColor,
              fontSize: 20,
              fontFamily: 'Poppins',
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 10, 10, 0),
            child: Text(
              //คีย์เวิร์ดทั้งหมดของอัลบั้มนั้น
              keyword,
              style: TextStyle(
                color: MyStyle().blackColor,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
          )
        ],
        /*Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 56),
            height: size.height * 0.2 - 60,
            decoration: BoxDecoration(
              color: MyStyle().perpleColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
            ),
          ),*/

        ///////////// How to ///////////////
        /*Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: MyStyle().grayColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  //ShowImage(name: title, selectbum: selectbum)
                                  Edit_keyword_des_album()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 20),
                        Expanded(
                            child: Text(
                          "Edit keyword and description",
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => rename_album(
                                    name: title,
                                  )));

                      ;
                    },
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 20),
                        Expanded(
                            child: Text(
                          "Rename album",
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
                      print(this.title);
                      await AlertDialogs_manage_album.yesCancelDialog(context,
                          'Delete', 'are you sure?', this.title, "delete", "");
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

                */
      ),
    ));
  }
}
