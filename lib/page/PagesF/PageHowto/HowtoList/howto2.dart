import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';

import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/HowtoList/howto1.dart';
import 'package:project_photo_learn/page/PagesF/PageHowto/howtouse.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';
import 'package:project_photo_learn/page/Start/StartPage.dart';

class HowToUse22 extends StatefulWidget {
  //const HowToUse2({Key? key}) : super(key: key);
  String pagehow;
  HowToUse22({required this.pagehow});
  @override
  Howto2 createState() => Howto2(pagehowto: pagehow);
}

class Howto2 extends State<HowToUse22> {
  @override
  String pagehowto;
  Howto2({required this.pagehowto});
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
          'วิธีใช้งานการค้นหา',
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
                                    'ถ้าคุณต้องการค้นหารูปภาพ ทำได้ง่ายๆโดย \nในช่องข้างบนให้คุณพิมพ์ประโยคที่คุณต้องการค้นหา \nส่วนช่องข้างล่างให้เลือกคีย์เวิร์ดที่คุณต้องการค้นหา\nเมื่อใส่ครบถ้วนตามที่ต้องการแล้วกดค้นหาได้เลย',
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
                                        'images/Search1.png',
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
                                    'จะได้หน้าผลลัพธ์ของการค้นหา ประกอบไปด้วย\nรูปที่ได้จากประโยค และ รูปที่ได้จากคีย์เวิร์ด',
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
                                        'images/Search2.png',
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
