import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';

import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/HowtoList/howto1.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/HowtoList/howto2.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/HowtoList/howto3.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/HowtoList/howto4.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';
import 'package:project_photo_learn/page/Start/StartPage.dart';

// ignore: must_be_immutable
class HowToUse2 extends StatefulWidget {
  //const HowToUse2({Key? key}) : super(key: key);
  String pagehow;
  HowToUse2({required this.pagehow});
  @override
  _HowtoWidgetState createState() => _HowtoWidgetState(pagehowto: pagehow);
}

class _HowtoWidgetState extends State<HowToUse2> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String pagehowto;
  _HowtoWidgetState({required this.pagehowto});
  dynamic Request_page;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () async {
              if (pagehowto == "startpage") {
                Request_page = Start_page();
              } else {
                user_file user0 = new user_file();
                await user0.getdata_user_file();
                var user = await user0;
                var ListImgCloud;
                var listimageshow;

                if (await user.Login) {
                  list_album la = await new list_album();
                  await la.getimagefrom_api();
                  print(
                      'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                  listimageshow = await la.listimageshow;

                  listimagecloud listimgC = await new listimagecloud();
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

                Request_page = FirstState(
                    page: 3,
                    user: user,
                    listimageshow: listimageshow,
                    ListImgCloud: ListImgCloud,
                    AllTagAlbum: ListTag);
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Request_page));
            },
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          automaticallyImplyLeading: false,
          title: Text(
            'How to use',
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //verticalDirection: VerticalDirection.down,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 3, 9, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().blackColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: MyStyle().blackColor,
                                ),
                              ),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().blackColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'จัดการอัลบั้ม รูปภาพ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: MyStyle().blackColor,
                                        fontWeight: FontWeight.bold,
                                        //fontStyle: FontStyle.normal,
                                        fontFamily: 'Rajdhani',
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: MyStyle().blackColor,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HowToUse1(
                                                      pagehow: pagehowto,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'อธิบายขั้นตอนการสร้างอัลบั้ม แก้ไข ลบ \nและ การเพิ่มรูปภาพเพื่อให้แอปพลิเคชันประมวล\nรวมถึงการย้าย รูป และลบรูป ',
                                      // style: FlutterFlowTheme.of(context).subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 3, 9, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().perpleColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: MyStyle().perpleColor,
                                ),
                              ),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().perpleColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'วิธีใช้งานคลาวด์ ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: MyStyle().blackColor,
                                        fontWeight: FontWeight.bold,
                                        //fontStyle: FontStyle.normal,
                                        fontFamily: 'Rajdhani',
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: MyStyle().blackColor,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HowToUse3(
                                                      pagehow: pagehowto,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'อธิบายขั้นตอนการอัปโหลดรูปขึ้นคลาวด์ และ \nดาวน์โหลดรูปากคลาวด์ลงเครื่อง',
                                      // style: FlutterFlowTheme.of(context).subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 3, 9, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().blackColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: MyStyle().blackColor,
                                ),
                              ),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().blackColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'วิธีค้นหารูป',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: MyStyle().blackColor,
                                        fontWeight: FontWeight.bold,
                                        //fontStyle: FontStyle.normal,
                                        fontFamily: 'Rajdhani',
                                      ),
                                      //style: FlutterFlowTheme.of(context).bodyText2,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: MyStyle().blackColor,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HowToUse22(
                                                      pagehow: pagehowto,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'อธิบายขั้นตอนการค้นหารูป โดยการใส่คีย์เวิร์ด \nหรือ ประโยคที่ต้องการค้นหา',
                                      // style: FlutterFlowTheme.of(context).subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 3, 9, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().perpleColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: MyStyle().perpleColor,
                                ),
                              ),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: MyStyle().perpleColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'วิธีเปลี่ยนชื่อผู้ใช้ รหัสผ่าน',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: MyStyle().blackColor,
                                        fontWeight: FontWeight.bold,
                                        //fontStyle: FontStyle.normal,
                                        fontFamily: 'Rajdhani',
                                      ),
                                      //style: FlutterFlowTheme.of(context).bodyText2,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: MyStyle().blackColor,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HowToUse4(
                                                      pagehow: pagehowto,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'อธิบายขั้นตอนการเปลี่ยนชื่อผู้ใช้ และ \nเปลี่ยนรหัส๋ผ่าน',
                                      // style: FlutterFlowTheme.of(context).subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
