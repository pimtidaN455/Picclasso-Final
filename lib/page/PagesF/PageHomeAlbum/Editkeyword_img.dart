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
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImageSliderPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

var suggestTag2 = ["Pizza", "Pasta", "Spagetti"];

class Edit_keyword_img extends StatefulWidget {
  var keyword;
  var namealbumS;
  var selectpicS;
  var listimageshow;
  var status_album;
  var keyimg;

  var status;
  Edit_keyword_img(
      {required this.keyword,
      required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required this.status,
      required this.keyimg,
      required this.status_album});
  @override
  Edit_keyword_imgState createState() => Edit_keyword_imgState(
      keyword: this.keyword,
      namealbumS: this.namealbumS,
      selectpicS: this.selectpicS,
      listimageshow: this.listimageshow,
      status: this.status,
      keyimg: this.keyimg,
      status_album: this.status_album);
}

class Edit_keyword_imgState extends State<Edit_keyword_img> {
  var keyword;
  var namealbumS;
  var selectpicS;
  var listimageshow;
  var status_album;
  var keyimg;
  var status;

  Edit_keyword_imgState(
      {required this.keyword,
      required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required this.status,
      required this.status_album,
      required this.keyimg});
  late double screen;
  final controller = new TagStateController();

  TextEditingController ConfirmEdit_KeywordJa = TextEditingController();
  TextEditingController Edit_des = TextEditingController();
  TextEditingController Edit_Keyword = TextEditingController();

  //สร้างตัวแปร fromKey
//  final _EdKeyword = GlobalKey<FormState>();
  final _EdDes = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("หน้าแก้ไขรับอันนี้มาาา");
    print(keyword.runtimeType);

    print(keyword);

    for (int i = 0; i < keyword.length; ++i) {
      if (controller.listTagBum.contains(keyword[i]) != true) {
        controller.listTagBum.add(keyword[i]);
      }
    }

    //controller.listTagBum.add(keyword);
    //Edit_Keyword = TextEditingController(text: keyword);

    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Edit keyword image",
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
              print("///////////////////*****////////////////////");
              print(this.keyimg);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SlideImage(
                          namealbumS: namealbumS,
                          selectpicS: selectpicS,
                          listimageshow: this.listimageshow,
                          status: this.status,
                          keyimg: this.keyimg,
                          status_album: this.status_album)));

              /////
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
          '   Edit keyword',
          style: TextStyle(
            fontSize: 25,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.normal,
            fontFamily: 'Rajdhani',
          ),
        ),
        ////////////////////////////////////////////////////
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
        //////////////////////////////////////////////////////
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

  Container ConfirmEdit_Keyword() {
    return Container(
      margin: EdgeInsets.all(50.0),
      width: screen * 0.75,
      child: ElevatedButton(
        child: Text('Confirm'),
        onPressed: () async {
          use_API api = new use_API();
          await api.updatekeyword_image(
              namealbumS, keyimg, controller.listTagBum);
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Update keyword success'),
            ),
          );

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Edit_keyword_img(
                      keyword: controller.listTagBum,
                      namealbumS: this.namealbumS,
                      selectpicS: this.selectpicS,
                      listimageshow: this.listimageshow,
                      keyimg: this.keyimg,
                      status: this.status,
                      status_album: this.status_album)));
        },
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
