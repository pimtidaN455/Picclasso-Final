import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Edit_keyword_des.dart';
//import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImageSliderPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manage_album_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/renameAlbum.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/selectImage_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_client.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_server.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/ShowImage_for_search_.dart';

import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

//enum Menu { itemZero, itemOne, itemTwo, itemThree }

// ignore: must_be_immutable
class Select_Text_Show extends StatefulWidget {
  var word_for_des;
  var keyall;

  var listimageshow_search_des;
  Select_Text_Show({
    required this.word_for_des,
    required this.listimageshow_search_des,
    required this.keyall,
  });
  @override
  _Select_Text_Show createState() => _Select_Text_Show(
        word_for_des: this.word_for_des,
        listimageshow_search_des: this.listimageshow_search_des,
        keyall: this.keyall,
      );
}

class _Select_Text_Show extends State<Select_Text_Show> {
  var searchFieldController;
  int optionSelected = 0;

  var keyall;
  var listimageshow_search_des;

  var word_for_des; //อัลบั้มที่ผู้ใช้เลือก
  _Select_Text_Show({
    required this.word_for_des,
    required this.listimageshow_search_des,
    required this.keyall,
  });

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
  }

  @override
  void dispose() {
    searchFieldController?.dispose();
    super.dispose();
  }

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  var count = 0;
  var nub = 0;

  @override
  Widget build(BuildContext context) {
    print("Select Text รับอะไรมาบ้าง ");
    print("ผลลัพธ์จาก key");
    //print((this.keyall["namekey"]).length);
    print(this.keyall);
    print("ผลลัพธ์จาก des");
    print(this.word_for_des);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyStyle().blackColor,
          ),
          onPressed: () async {
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

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FirstState(
                        page: 1,
                        user: user,
                        listimageshow: listimageshow,
                        ListImgCloud: ListImgCloud,
                        AllTagAlbum: ListTag)));
          },
        ),

        /////////////////// แถบบน //////////////////////////////
        title: Text(
          ("Search results").toString(),
          style: TextStyle(
            fontSize: 30,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.normal,
            fontFamily: 'Rajdhani',
          ),
        ),

        //centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyStyle().whiteColor,

        /////////////////// แถบบน //////////////////////////////
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (word_for_des.length != 0)
              select_gotoshowDes(
                word_for_des: this.word_for_des,
                listimageshow_search_des: this.listimageshow_search_des,
                keyall: this.keyall,
              ),
            if (keyall.length != 0)
              for (int i = 0; i < keyall.length; i++)
                select_gotoshow_key(
                  img_key: keyall[i]['imagekey'],
                  namekeyall: this.keyall[i]["namekey"],
                  word_for_des: this.word_for_des,
                  keyall: this.keyall,
                  listimageshow_search_des: this.listimageshow_search_des,
                ),
          ],
        ),
      ),
    );
  }
}

class select_gotoshow_key extends StatelessWidget {
  select_gotoshow_key({
    required this.namekeyall,
    required this.img_key,
    required this.word_for_des,
    required this.keyall,
    required this.listimageshow_search_des,
  });
  var word_for_des;
  var keyall;

  var listimageshow_search_des;

  var img_key;
  var namekeyall;
  var len_img_all_des = 0;
  @override
  Widget build(BuildContext context) {
    len_img_all_des = img_key['device'].length + img_key['cloud'].length;
    //print('ลองงง');
    //print(this.listimageshow_search_des["device"][1]["img"]);
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
      Row(),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Keyword : " + this.namekeyall.toString(),
              style: TextStyle(
                fontSize: 20,
                color: MyStyle().blackColor,
                fontWeight: FontWeight.bold,
                //fontStyle: FontStyle.normal,
                fontFamily: 'Rajdhani',
              ),
            ),
          ],
        ),
      ),
      if (img_key['device'].length == 0 && img_key['cloud'].length == 0)
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "--------------------------" +
                    "\n" +
                    "The image you searched for was not found." +
                    "\n" "--------------------------",
                style: TextStyle(
                  fontSize: 20,
                  color: MyStyle().deleteColor,
                  fontWeight: FontWeight.bold,
                  //fontStyle: FontStyle.normal,
                  fontFamily: 'Rajdhani',
                ),
              ),
            ],
          ),
        ),

      if (img_key["device"].length == 0 && img_key["cloud"].length != 0)
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: ListView(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color: MyStyle().grayColor,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image:
                                NetworkImage(this.img_key["cloud"][0]["img"]),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: MyStyle().grayColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Number of images discovered : ' +
                                              len_img_all_des.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: MyStyle().blackColor,
                                            fontWeight: FontWeight.bold,
                                            //fontStyle: FontStyle.normal,
                                            fontFamily: 'Rajdhani',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Text("Show more"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      //ShowImage(name: title, selectbum: selectbum)
                                                      ShowImage_for_search_(
                                                          word_for_des:
                                                              this.word_for_des,
                                                          keyall: this.keyall,
                                                          listimageshow_search_des:
                                                              this
                                                                  .listimageshow_search_des,
                                                          img_key: this.img_key,
                                                          namekey: this
                                                              .namekeyall
                                                              .toString())));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ])),
      //if (listimageshow_search_des.length != 0)
      if ((img_key["device"].length != 0 && img_key["cloud"].length != 0) ||
          (img_key["device"].length != 0 && img_key["cloud"].length == 0))
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: ListView(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color: MyStyle().grayColor,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: FileImage(
                                File(this.img_key["device"][0]["img"])),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: MyStyle().grayColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Number of images found : ' +
                                              len_img_all_des.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: MyStyle().blackColor,
                                            fontWeight: FontWeight.bold,
                                            //fontStyle: FontStyle.normal,
                                            fontFamily: 'Rajdhani',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Text("Show more"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      //ShowImage(name: title, selectbum: selectbum)
                                                      ShowImage_for_search_(
                                                          word_for_des:
                                                              this.word_for_des,
                                                          keyall: this.keyall,
                                                          listimageshow_search_des:
                                                              this
                                                                  .listimageshow_search_des,
                                                          img_key: this.img_key,
                                                          namekey: this
                                                              .namekeyall
                                                              .toString())));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ])),
    ]));
  }
}

class select_gotoshowDes extends StatelessWidget {
  select_gotoshowDes({
    required this.listimageshow_search_des,
    required this.word_for_des,
    required this.keyall,
  });
  var listimageshow_search_des;
  var word_for_des;
  var keyall;
  var len_img_all_des = 0;

  @override
  Widget build(BuildContext context) {
    len_img_all_des = listimageshow_search_des['device'].length +
        listimageshow_search_des['cloud'].length;
    //print('ลองงง');
    //print(this.listimageshow_search_des["device"][1]["img"]);
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
      Row(),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Sentence search : " + this.word_for_des.toString(),
              style: TextStyle(
                fontSize: 20,
                color: MyStyle().blackColor,
                fontWeight: FontWeight.bold,
                //fontStyle: FontStyle.normal,
                fontFamily: 'Rajdhani',
              ),
            ),
          ],
        ),
      ),
      if (listimageshow_search_des['device'].length == 0 &&
          listimageshow_search_des['cloud'].length == 0)
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "---------------------------------------------------------" +
                    "\n" +
                    "The image you searched for was not found." +
                    "\n"
                        "----------------------------------------------------------",
                style: TextStyle(
                  fontSize: 20,
                  color: MyStyle().deleteColor,
                  fontWeight: FontWeight.bold,
                  //fontStyle: FontStyle.normal,
                  fontFamily: 'Rajdhani',
                ),
              ),
            ],
          ),
        ),

      if (listimageshow_search_des["device"].length == 0 &&
          listimageshow_search_des["cloud"].length != 0)
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: ListView(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color: MyStyle().grayColor,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(this
                                .listimageshow_search_des["cloud"][0]["img"]),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: MyStyle().grayColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Number of images found : ' +
                                              len_img_all_des.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: MyStyle().blackColor,
                                            fontWeight: FontWeight.bold,
                                            //fontStyle: FontStyle.normal,
                                            fontFamily: 'Rajdhani',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Text("Show more"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      //ShowImage(name: title, selectbum: selectbum)
                                                      ShowImage_for_search_(
                                                          word_for_des:
                                                              this.word_for_des,
                                                          keyall: this.keyall,
                                                          listimageshow_search_des:
                                                              this
                                                                  .listimageshow_search_des,
                                                          img_key: this
                                                              .listimageshow_search_des,
                                                          namekey: this
                                                              .word_for_des)));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ])),
      //if (listimageshow_search_des.length != 0)
      if ((listimageshow_search_des["device"].length != 0 &&
              listimageshow_search_des["cloud"].length != 0) ||
          (listimageshow_search_des["device"].length != 0 &&
              listimageshow_search_des["cloud"].length == 0))
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: ListView(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color: MyStyle().grayColor,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: FileImage(File(this
                                .listimageshow_search_des["device"][0]["img"])),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: MyStyle().grayColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Number of images found : ' +
                                              len_img_all_des.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: MyStyle().blackColor,
                                            fontWeight: FontWeight.bold,
                                            //fontStyle: FontStyle.normal,
                                            fontFamily: 'Rajdhani',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Text("Show more"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      //ShowImage(name: title, selectbum: selectbum)
                                                      ShowImage_for_search_(
                                                          word_for_des:
                                                              this.word_for_des,
                                                          keyall: this.keyall,
                                                          listimageshow_search_des:
                                                              this
                                                                  .listimageshow_search_des,
                                                          img_key: this
                                                              .listimageshow_search_des,
                                                          namekey: this
                                                              .word_for_des)));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ])),
    ]));
  }
}
