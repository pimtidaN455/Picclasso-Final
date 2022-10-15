import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

var suggestTag2 = ["Pizza", "Pasta", "Spagetti"];

class Delete_Album extends StatefulWidget {
  const Delete_Album({Key? key}) : super(key: key);
  @override
  Delete_AlbumState createState() => Delete_AlbumState();
}

class Delete_AlbumState extends State<Delete_Album> {
  late double screen;
  final controller = Get.put(TagStateController());
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
          "Edit Album",
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
          '   Desription',
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
          '   Keyword',
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
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: Add_Keyword_SubJ,
              onEditingComplete: () {
                controller.listTagBum.add(Add_Keyword_SubJ.text);
                Add_Keyword_SubJ.clear();
              },
              autofocus: false,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tag',
                //contentPadding: EdgeInsets.symmetric(vertical: 2),
                prefixIcon: Icon(Icons.tag),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (Add_Keyword_SubJ.text != "") {
                      controller.listTagBum.add(Add_Keyword_SubJ.text);
                    }
                    Add_Keyword_SubJ.clear();
                  },
                  icon: const Icon(Icons.add),
                ),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            suggestionsCallback: (String pattern) {
              return suggestTag2.where(
                  (e) => e.toLowerCase().contains(pattern.toLowerCase()));
            },
            onSuggestionSelected: (String suggestion) =>
                controller.listTagBum.add(suggestion),
            itemBuilder: (BuildContext context, Object? itemData) {
              return ListTile(
                leading: Icon(Icons.tag),
                title: Text(itemData.toString()),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "   # ที่คุณต้องการเพิ่ม ",
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        Obx(() => controller.listTagBum.length == 0
            ? Center(
                child: Text('\n No tag'),
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
        buttonaddbum(),
      ])),
    );
  }

  Container AddNameSubJ() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: screen * 0.8,
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
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
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
      width: screen * 0.8,
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
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
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
          bool validate = _fromKey.currentState!.validate();
          if (validate) {
            print(Add_Name_SubJ.text);
            var keyword = "";
            for (int i = 0; i < controller.listTagBum.length; ++i) {
              keyword += (controller.listTagBum[i]) + "/";
            }
            use_API use_api = new use_API();
            await use_api.manage_Album(
                Add_Name_SubJ.text, Add_des.text, keyword, "", "add");
            print(controller.listTagBum);

            user_file user = await new user_file();
            await user.getdata_user_file();
            var user0 = await user;
            var ListImgCloud;
            var listimageshow;

            //

            if (await user.Login) {
              list_album la = new list_album();
              var ListImageDevice = await la.getimagefrom_api();
              print(
                  'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
              print(await la.listimageshow_device);
              listimagecloud listimgC = new listimagecloud();
              ListImgCloud = await listimgC.getimagefrom_api();
              print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
              for (int i = 0; i < ListImgCloud.length; i++) {
                print(await ListImgCloud[i].gettoString());
              }
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
          } else {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => Delete_Album());
            Navigator.of(this.context).push(materialPageRoute);
          }

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
