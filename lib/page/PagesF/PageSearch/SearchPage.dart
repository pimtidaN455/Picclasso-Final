// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/Select_Text_show.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/search.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';

class Searchpage extends StatelessWidget {
  List<String> AllTagAlbum = [];
  Searchpage({
    required this.AllTagAlbum,
  });

  final controller = Get.put(TagStateController());
  final textController = TextEditingController();
  final textControllerText = TextEditingController();
  late double screen;

  //final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 30,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "\n   Description search. ",
                style: TextStyle(
                  fontSize: 20,
                  color: MyStyle().blackColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rajdhani',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: textControllerText,
                  onEditingComplete: () {
                    controller.listTagSearch.add(textControllerText.text);
                    textControllerText.clear();
                  },
                  autofocus: false,
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.italic),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Text you want to search ',
                    //prefixIcon: Icon(Icons.tag),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "  Keyword search. ",
                  style: TextStyle(
                    fontSize: 20,
                    color: MyStyle().blackColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rajdhani',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: textController,
                    onEditingComplete: () {
                      controller.listTagSearch.add(textController.text);
                      textController.clear();
                    },
                    autofocus: false,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontStyle: FontStyle.italic),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Keywords you want to search ',
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (textController.text != "") {
                            //controller.listTagBum.add(keyword);
                            controller.listTagSearch.add(textController.text);
                          }
                          textController.clear();
                        },
                        icon: const Icon(Icons.add),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  suggestionsCallback: (String pattern) {
                    return this.AllTagAlbum.where(
                        (e) => e.toLowerCase().contains(pattern.toLowerCase()));
                  },
                  onSuggestionSelected: (String suggestion) =>
                      controller.listTagSearch.add(suggestion),
                  itemBuilder: (BuildContext context, Object? itemData) {
                    return ListTile(
                      //leading: Icon(Icons.tag),
                      title: Text(itemData.toString()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "   All the keywords you want to find.",
                style: TextStyle(
                  fontSize: 20,
                  color: MyStyle().blackColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rajdhani',
                ),
              ),
              Obx(() => controller.listTagSearch.length == 0
                  ? Center(
                      child: Text('\n You do not have what you want to find.'),
                    )
                  : Wrap(
                      children: controller.listTagSearch
                          .map((element) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Chip(
                                  label: Text(element),
                                  deleteIcon: Icon(Icons.clear),
                                  onDeleted: () =>
                                      controller.listTagSearch.remove(element),
                                ),
                              ))
                          .toList(),
                    )),
              Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  direction: Axis.horizontal,
                  children: [
                    buttonSearch(context),
                  ])
            ])),
      ),
    );
  }

  Container buttonSearch(var context) {
    return Container(
      margin: EdgeInsets.all(50.0),
      width: screen * 0.75,
      child: ElevatedButton(
        child: Text('Search'),
        onPressed: () async {
          print(textController.text);
          ManageTag mnTag = new ManageTag();
          var Tag = await mnTag.getTagAlbum();
          print('--------------- Add Album ---------------');
          //print(Tag);
          use_API api = new use_API();

          var detectword = await api.detect_word(textControllerText.text);
          search s = new search();
          //  print(controller.listTagSearch);
          var true_word =
              s.manage_word(controller.listTagSearch, textControllerText.text);
          //print(true_word);
          DBHelper db = new DBHelper();

          var keyword_list = controller.listTagSearch;
          var descriptions_search = textControllerText.text;
          print("/*************/");
          var data_search = await db.getPhoto();
          print(descriptions_search);
          print(descriptions_search.length);
          print("/*************/");
          if (true_word.length != 0) {
            var answer_search_des =
                await s.use_search_IR(descriptions_search); // คำตอบ des
            var answer_search_key = await s.use_search_keyword(keyword_list);
            //คำตอบ keyword
            print("////////////////c///////////////////");
            print(answer_search_des);
            print(answer_search_key);
            print("////////////////c///////////////////");
            var listimageshow_search_for_des;

            //descriptions_search
            use_API api = new use_API();
            if (answer_search_des['message'] ||
                answer_search_key["status_all"]) {
              if (answer_search_des['message'] &&
                  descriptions_search.length != 0) {
                listimageshow_search_for_des = await s.data_image_answer_search(
                    answer_search_des['data_img_search']);
                print("////////////////des///////////////////");
                print(listimageshow_search_for_des);
              }
              if (answer_search_des['message'] == false) {
                listimageshow_search_for_des = {};
                listimageshow_search_for_des['device'] = [];
                listimageshow_search_for_des['cloud'] = [];
                //  listimageshow_search_for_des
              }
              var keyall = [];
              if (answer_search_key["status_all"]) {
                for (int i = 0; i < keyword_list.length; i++) {
                  var key = {};
                  key["namekey"] = keyword_list[i];
                  key["imagekey"] = [];
                  //if(answer_search_key["Data_search"])
                  key["imagekey"] = await s.data_image_answer_search(
                      answer_search_key["Data_search"][i]["All_image"]);
                  print("listimageshow_search_for_keys");

                  keyall.add(key);
                }
              }
              print("คียยยยย์ ทั้งหมดดดดดด");
              print(keyall);
              print(keyall.length);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          //ShowImage(name: title, selectbum: selectbum)
                          Select_Text_Show(
                            word_for_des: descriptions_search,
                            keyall: keyall,
                            listimageshow_search_des:
                                listimageshow_search_for_des,
                          )));
              //    answer_search_des['data_img_search'];  ///key ภาพ
              // answer_search_key['list_img']; เรียก ข้อมูลทั้งหมด
              // answer_search_key['list_img'][0] - length ; เป็นข้อมูล ของคีย์เวอร์ดทั้งหมด

              //ข้อมูล list ของ key
              // answer_search_key['list_img'][i]['keyword']   แสดงตีย์เวิร์ด type: String
              // answer_search_key['list_img'][i]['status']  บอกว่ามี ภาพที่พบหรือไม่ true or false type: boolean
              // answer_search_key['list_img'][i]['device'] แสดงภาพที่เป็น device type: map
              // answer_search_key['list_img'][i]['cloud'] แสดงภาพที่เป็น cloud  type: map
              //   (โดยที่ i  < length)

              /////==========> ไปหน้าแสดงภาพ
            } else {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('The image you searched for was not found.'),
                ),
              );
            }
          } else {
            await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Please enter a search term.'),
              ),
            );
          }
          print("fff");
        },
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
