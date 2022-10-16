import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

class Add_Album_Page extends StatefulWidget {
  const Add_Album_Page({Key? key}) : super(key: key);
  @override
  Add_Album_PageState createState() => Add_Album_PageState();
}

class Add_Album_PageState extends State<Add_Album_Page> {
  late double screen;
  final controller = new TagStateController();
  TextEditingController Add_Name_SubJ = TextEditingController();
  TextEditingController Add_des = TextEditingController();
  TextEditingController Add_Keyword_SubJ = TextEditingController();
  //สร้างตัวแปร fromKey
  final _fromKey = GlobalKey<FormState>();
  final _fromKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add Album",
          style: TextStyle(
            fontSize: 30,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
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
              /*for (int i = 0; i < ListImgCloud.length; i++) {
                  print(await ListImgCloud[i].gettoString());
                }*/
            }

            var ListTag = [];
            ManageTag mnt = new ManageTag();
            ListTag = await mnt.getTagAlbum();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FirstState(
                        page: 0,
                        user: user,
                        listimageshow: listimageshow,
                        ListImgCloud: ListImgCloud,
                        AllTagAlbum: ListTag)));
          },
        ),
        backgroundColor: MyStyle().whiteColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "\n   Name of subject",
                style: TextStyle(
                  fontSize: 25,
                  color: MyStyle().blackColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rajdhani',
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Form(
                    key: _fromKey,
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        AddNameSubJ(),
                      ],
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                '   Add Desription',
                style: TextStyle(
                  fontSize: 25,
                  color: MyStyle().blackColor,
                  fontWeight: FontWeight.bold,
                  //fontStyle: FontStyle.normal,
                  fontFamily: 'Rajdhani',
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Form(
                    key: _fromKey2,
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        AddDesription(),
                      ],
                    ),
                  )),
              Text(
                '   Add keyword',
                style: TextStyle(
                  fontSize: 25,
                  color: MyStyle().blackColor,
                  fontWeight: FontWeight.bold,
                  //fontStyle: FontStyle.normal,
                  fontFamily: 'Rajdhani',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: Add_Keyword_SubJ,
                  onEditingComplete: () {
                    controller.listTagAdd.add(Add_Keyword_SubJ.text);
                    Add_Keyword_SubJ.clear();
                  },
                  autofocus: false,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Keyword',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (Add_Keyword_SubJ.text != "") {
                          //controller.listTagBum.add(keyword);
                          controller.listTagAdd.add(Add_Keyword_SubJ.text);
                        }
                        Add_Keyword_SubJ.clear();
                      },
                      icon: const Icon(Icons.add),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "    You want to add ",
                style: TextStyle(
                  fontSize: 20,
                  color: MyStyle().blackColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rajdhani',
                ),
              ),
              Obx(() => controller.listTagAdd.length == 0
                  ? Center(
                      child: Text('\n No Keyword'),
                    )
                  : Wrap(
                      children: controller.listTagAdd
                          .map((element) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Chip(
                                  label: Text(element),
                                  deleteIcon: Icon(Icons.clear),
                                  onDeleted: () =>
                                      controller.listTagAdd.remove(element),
                                ),
                              ))
                          .toList(),
                    )),
              buttonaddbum(),
            ])),
      ),
    );
  }

  Container AddNameSubJ() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: screen * 0.95,
      child: TextFormField(
        controller: Add_Name_SubJ,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                Add_Name_SubJ.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            labelText: 'Name of suject',
            //prefixIcon: Icon(Icons.email_outlined),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          final Add_Name_SubJ = RegExp(r"^[a-zA-Zก-๏\s]");
          if (value!.isEmpty) {
            return "Please enter name of subject";
          }
          if (Add_Name_SubJ.hasMatch(value)) {
            return null;
          } else
            return "Please enter a-z A-Z 0-9 ก-ฮ ";
        },
      ),
    );
  }

  Container AddDesription() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: screen * 0.95,
      child: TextFormField(
        controller: Add_des,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                Add_des.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            labelText: 'AddDesription',
            //prefixIcon: Icon(Icons.email_outlined),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          final Add_des = RegExp(r"^[a-zA-Zก-๏\s]");
          if (value!.isEmpty) {
            return "Please enter name of subject";
          }
          if (Add_des.hasMatch(value)) {
            return null;
          } else
            return "Please enter a-z A-Z 0-9 ก-ฮ ";
        },
      ),
    );
  }

  Container buttonaddbum() {
    return Container(
      margin: EdgeInsets.all(50.0),
      width: screen * 0.75,
      child: ElevatedButton(
        child: Text('Add Album'),
        onPressed: () async {
          print('--------------- Add Album ---------------');

          DBHelper db = new DBHelper();
          var allalbum = await db.getAlbum();
          var statusalbum_repeatedly = false;
          print(Add_Name_SubJ.text);
          for (int i = 0; i < allalbum.length; ++i) {
            if (allalbum[i]['NAMEALBUM'] == Add_Name_SubJ.text) {
              statusalbum_repeatedly = true;
              print("///true////");
            }
          }
          print(statusalbum_repeatedly);
          bool validate = _fromKey.currentState!.validate();
          if (validate && statusalbum_repeatedly == false) {
            print(Add_Name_SubJ.text);
            var keyword = "";
            for (int i = 0; i < controller.listTagAdd.length; ++i) {
              keyword += (controller.listTagAdd[i]) + "/";
            }

            use_API use_api = new use_API();
            use_api.manage_Album(
                Add_Name_SubJ.text, "", keyword, Add_des.text, "add");
            //  (namealbum, nameoldalbum, keyword, description, status)
            print(controller.listTagAdd);
            print(keyword);
            print(Add_des.text);
            user_file user = await new user_file();
            await user.getdata_user_file();
            var user0 = await user;
            var ListImgCloud;
            var listimageshow;

            //

            if (await user.Login) {
              /* DBHelper db = DBHelper();
              await db.deletedata_intable();*/

              list_album la = new list_album();
              await la.getimagefrom_api();
              print(
                  'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
              print(await la.listimageshow_device);
              listimagecloud listimgC = new listimagecloud();
              ListImgCloud = await listimgC.getimagefrom_api();
              listimageshow = await la.listimageshow;
              print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
              /*  for (int i = 0; i < ListImgCloud.length; i++) {
                print(await ListImgCloud[i].gettoString());
              }*/
            }
            await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('The album was created successfully.'),
              ),
            );

            var ListTag = [];
            ManageTag mnt = new ManageTag();
            ListTag = await mnt.getTagAlbum();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FirstState(
                        page: 0,
                        user: user,
                        listimageshow: listimageshow,
                        ListImgCloud: ListImgCloud,
                        AllTagAlbum: ListTag)));
          } /*else {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => Add_Album_Page());
            Navigator.of(this.context).push(materialPageRoute);
          }

          controller.listTagAdd.clear();*/

          if (statusalbum_repeatedly) {
            await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                    "Duplicate album name or this is the app's album name."),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
