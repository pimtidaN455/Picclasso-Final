import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';

import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/HowtoList/howto1.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/HowtoList/howto2.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/howtouse.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';
import 'package:project_photo_learn/page/Start/StartPage.dart';

class HowToUse1 extends StatefulWidget {
  //const HowToUse2({Key? key}) : super(key: key);
  String pagehow;
  HowToUse1({required this.pagehow});
  @override
  Howto1 createState() => Howto1(pagehowto: pagehow);
}

class Howto1 extends State<HowToUse1> {
  @override
  String pagehowto;
  Howto1({required this.pagehowto});
  dynamic Request_page;
  // ignore: override_on_non_overriding_member
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () async {
            if (pagehowto == "startpage") {
              Request_page = HowToUse2(pagehow: 'startpage');
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

              Request_page = HowToUse2(pagehow: 'Person');
            }
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Request_page));
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        automaticallyImplyLeading: false,
        title: Text(
          'การจัดการอัลบั้ม และ รูปภาพ',
          style: TextStyle(
            fontSize: 20,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'เมื่อ login เข้าไปแล้วจะเข้าสู่หน้าอัลบั้มเป็นหน้าแรก \nซึ่งวิธีเพิ่มอัลบั้มทำได้ง่ายๆโดยกดปุ่มเพิ่มไฟล์สีเขียว\nด้านบนขวา \n',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/Home.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\n แล้วใส่รายละเอียดอัลบั้มประกอบไปด้วย \nชื่ออัลบั้ม คำอธิบายรายวิชา และ คีย์เวิร์ด',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/AddBum2.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\n เมื่อสร้างอัลบั้มสำเร็จแล้ว อัลบั้มที่สร้างไว้ก็จะ\nปรากฎอยู่บนหน้าอัลบั้ม\n\nในกรณีที่รูปภาพยังไม่มีในอัลบั้มวิชานั้นจะปรากฎ\nอัลบั้มเป็นรูป ไอคอนรูปภาพโดนขีดค่า\n',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/ALBUM1.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\nในการแก้ไขอัลบั้มนั้น ผู้ใช้สามารถทำได้โดย \nกดไปที่อัลบั้มที่ต้องการแก้ไข เลือกจุด 3 จุด\nด้านบนขวามือจะมีเมนูให้เลือก 4 ตัวเลือก \nประกอบไปด้วย \n - ดูข้อมูลอัลบั้ม \n - เปลี่ยนชื่ออัลบั้ม \n - แก้ไขคีย์เวิร์ด และ คำอธิบายวิชา \n - ลบอัลบั้ม',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/ALBUM2.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'การเพิ่มรูปภาพเพื่อให้แอปพลิเคชันทำการคัดแยก\nเข้าอัลบั้มวิชาต่างๆทำได้โดยกดปุ่มเพิ่มรูปทาง\nด้านบนขวาอันที่ 2 แล้วจะเข้ามาในหน้าเลือกรูป',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/select.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'เมื่อทำการเพิ่มรูปสำเร็จแล้ว แอปพลิเคชันจะ\nนำรูปไปประมวลผลแล้วคัดแยกรูปเข้าอัลบั้ม\nให้โดยอัตโนมัติ โดยจะแบ่งการแยกเป็น\n\n - รูปที่ไม่ใช่เอกสารการเรียน\nแอปพลิเคชันจะทำการสร้างอัลบั้มตามหมวดที่มี\nอยู่ให้อัตโนมัติ \n\n - รูปที่เป็นเอกสารการเรียนแต่ไม่มีเนื้อหาใน\nอัลบั้มวิชารูปภาพนั้นจะถูกนำไปไว้ในอัลบั้ม\nDocument+Education \n\n - รูปที่เป็นเอกสารการเรียนมีเนื้อหาใน\nอัลบั้มวิชารูปภาพนั้นจะถูกนำไปไว้ในอัลบั้มวิชาต่างๆ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/AddBum1.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'สามารถดูรูปในอัลบั้มได้โดยคลิ๊กอัลบั้มที่ต้องการ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/allpic.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'การย้ายรูปภาพ สามารถทำได้โดย\n\n1. กดไอคอนย้ายไฟล์ด้านบนขวา\n2. กดเลือกรูปภาพที่ต้องการย้าย\n3. เลือกอัลบั้มที่ต้องการย้ายไป\n4. กดยืนยันการย้าย',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/allpic.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/Yai.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'การลบรูปภาพ สามารถทำได้โดย\n1. กดไอคอนถังขยะด้านบนขวา \n2. กดเลือกรูปที่ต้องการลบ \n3. กดยืนยันการลบ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: MyStyle().blackColor,
                                      fontFamily: 'Rajdhani',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/allpic.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 500,
                                      //clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/Delete.png',
                                        width: 500,
                                        height: 500,
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
