import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

var suggestTag2 = ["Pizza", "Pasta", "Spagetti"];

class Edit_keyword_des_album extends StatefulWidget {
  var name;
  var description;
  var keyword;
  Edit_keyword_des_album(
      {required this.description, required this.keyword, required this.name});
  @override
  Edit_keyword_des_albumState createState() => Edit_keyword_des_albumState(
      description: this.description, keyword: this.keyword, name: this.name);
}

class Edit_keyword_des_albumState extends State<Edit_keyword_des_album> {
  var description;
  var keyword;
  var name;
  Edit_keyword_des_albumState(
      {required this.description, required this.keyword, required this.name});
  late double screen;
  final controller = new TagStateController();

  TextEditingController ConfirmEdit_KeywordJa = TextEditingController();
  TextEditingController Edit_des = TextEditingController();
  TextEditingController Edit_Keyword = TextEditingController();
  final _EdDes = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("หน้าแก้ไขรับอันนี้มาาา");
    print(keyword.runtimeType);
    print(description);
    print(keyword);

    Edit_des = TextEditingController(text: description);
    for (int i = 0; i < keyword.length; ++i) {
      if (controller.listTagBum.contains(keyword[i]) != true) {
        controller.listTagBum.add(keyword[i]);
      }
    }
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Edit Keyword and Description",
          style: TextStyle(
            fontSize: 25,
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
                      builder: (context) => ShowImage(
                          name: title,
                          listimageshow: showDevice,
                          statusAlbum: "Usercreate")));
            }),
        backgroundColor: MyStyle().whiteColor,
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20,
        ),
        Text(
          '   Edit Desription',
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
              key: _EdDes,
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Edit_Desription(),
                ],
              ),
            )),
        Text(
          '   Edit keyword',
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
            controller: Edit_Keyword,
            onEditingComplete: () {
              if (Edit_Keyword.text != "")
                controller.listTagBum.add(Edit_Keyword.text);
              Edit_Keyword.clear();
            },
            autofocus: false,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "",
              //prefixIcon: Icon(Icons.tag),
              suffixIcon: IconButton(
                onPressed: () {
                  if (Edit_Keyword.text != "") {
                    //controller.listTagBum.add(keyword);
                    controller.listTagBum.add(Edit_Keyword.text);
                  }
                  Edit_Keyword.clear();
                },
                icon: const Icon(Icons.add),
              ),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "   keyword ที่คุณต้องการเพิ่ม ",
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        Obx(() => controller.listTagBum.length == 0
            ? Center(
                child: Text("\n Don't have keyword"),
              )
            : Wrap(
                children: controller.listTagBum
                    .map((element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(element),
                            deleteIcon: Icon(Icons.clear),
                            onDeleted: () =>
                                controller.listTagBum.remove(element),
                          ),
                        ))
                    .toList(),
              )),
        ConfirmEdit_Keyword(),
      ])),
    );
  }

  Container Edit_Desription() {
    return Container(
      padding: const EdgeInsets.all(1),
      margin: EdgeInsets.only(top: 10, bottom: 16),
      width: screen * 0.95,
      child: TextFormField(
        controller: Edit_des,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                Edit_des.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            hintText: this.description,
            //prefixIcon: Icon(Icons.email_outlined),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          final Edit_des = RegExp(r"^[a-zA-Zก-๏\s]");
          if (value!.isEmpty) {
            return "Please enter name of subject";
          }
          if (Edit_des.hasMatch(value)) {
            return null;
          } else
            return "Please enter a-z A-Z 0-9 ก-ฮ ";
        },
      ),
    );
  }

  Container ConfirmEdit_Keyword() {
    return Container(
      margin: EdgeInsets.all(50.0),
      width: screen * 0.75,
      child: ElevatedButton(
        child: Text('Confirm'),
        onPressed: () async {
          var newkeyword = "";

          for (int i = 0; i < controller.listTagBum.length; ++i) {
            newkeyword += (controller.listTagBum[i]) + "/";
          }
          print("////new////////////////");
          print(newkeyword);
          print("////new////////////////");
          use_API use_api = new use_API();
          use_api.manage_Album(
              this.name, "", newkeyword, Edit_des.text, "update");

          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('อัพเดทอัลบั้มสำเร็จ'),
            ),
          );
          //  (namealbum, nameoldalbum, keyword, description, status)
          print(controller.listTagBum);
          print(keyword);
          print(Edit_des.text);
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

          controller.listTagBum.clear();
        },
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
