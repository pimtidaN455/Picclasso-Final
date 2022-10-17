// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manage_album_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_client.dart';

class rename_album extends StatefulWidget {
  // const rename_album({Key? key}) : super(key: key);
  var name;
  var listimageshow;
  rename_album({required this.name, required this.listimageshow});
  @override
  _rename_albumState createState() =>
      _rename_albumState(name: this.name, listimageshow: this.listimageshow);
}

class _rename_albumState extends State<rename_album> {
  //String pagereset;
  //var user;
  var name;
  var listimageshow;
  _rename_albumState({required this.name, required this.listimageshow});

  late double screen;
  TextEditingController rename = TextEditingController();
  //bool _isObscure = true;
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              var title = this.name;
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
          title: Text(
            "Rename Album",
            style: TextStyle(
              fontSize: 30,
              color: MyStyle().blackColor,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          backgroundColor: MyStyle().whiteColor,
        ),
        body: Container(
          child: Container(
            alignment: Alignment.topLeft,

            //mainAxisSize: MainAxisSize.max,
            child: SingleChildScrollView(
              // alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsetsDirectional.fromSTEB(45, 10, 0, 0),
                  child: Text(
                    'Old Name Album : ' +
                        this.name +
                        "\n" +
                        "New name Album : ",
                    style: TextStyle(
                      fontSize: 20,
                      color: MyStyle().blackColor,
                      fontWeight: FontWeight.bold,
                      //fontStyle: FontStyle.normal,
                      fontFamily: 'Rajdhani',
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    key: _fromKey,
                    child: SingleChildScrollView(
                      // padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Namere(),
                        NextToRePassWord(),
                      ]),
                    )),
              ]),
            ),
          ),
        ));
  }

  Container Namere() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: rename,
        decoration: InputDecoration(
            hintText: name,
            prefixIcon: Icon(Icons.people_alt),
            suffixIcon: IconButton(
              onPressed: () {
                rename.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          final emailRegex = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
          if (value!.isEmpty) {
            return "Please enter Name";
          }
          if (emailRegex.hasMatch(value)) {
            return null;
          } else
            return "";
        },
      ),
    );
  }

  Container NextToRePassWord() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        /* onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
                'Application ได้ทำการส่ง Email เพื่อให้ผู้ใข้ทำการเปลี่ยนรหัสผ่านดรียบร้อย'),
          ),
        ),*/
        onPressed: () async {
          /*  var nameedit = [];
          nameedit.add(name);
          nameedit.add(rename.text);*/
          //  print(this.title);
          var itemEdit = {
            "namealbum": rename.text,
            "nameoldalbum": this.name,
            "keyword": "",
            "description": "",
            "status": "update"
          };

          if (rename.text.length == 0) {
            await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Please input new name'),
              ),
            );
          } else {
            await AlertDialogs_manage_album.yesCancelDialog(
                context,
                'Update name album',
                'are you sure?',
                this.name,
                "update",
                itemEdit,
                "");
          }
          print(rename.text);
          rename.text;
        },
        child: Text(
          'Confirm',
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.normal,
            fontFamily: 'Rajdhani',
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
