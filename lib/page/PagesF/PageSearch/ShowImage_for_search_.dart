import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Edit_keyword_des.dart';
//import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/ImageSliderPage_search.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/Select_Text_show.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

//enum Menu { itemZero, itemOne, itemTwo, itemThree }

// ignore: must_be_immutable
class ShowImage_for_search_ extends StatefulWidget {
  var word_for_des;
  var keyall;

  var listimageshow_search_des;

  var img_key;
  var namekey;

  ShowImage_for_search_(
      {required this.word_for_des,
      required this.keyall,
      required this.listimageshow_search_des,
      required this.img_key,
      required this.namekey});
  @override
  Allimages_search_key createState() => Allimages_search_key(
      word_for_des: this.word_for_des,
      keyall: this.keyall,
      listimageshow_search_des: this.listimageshow_search_des,
      img_key: this.img_key,
      namekey: this.namekey);
}

class Allimages_search_key extends State<ShowImage_for_search_> {
  int optionSelected = 0;
  var word_for_des;
  var keyall;

  var listimageshow_search_des;

  var img_key;
  var namekey;
  Allimages_search_key(
      {required this.word_for_des,
      required this.keyall,
      required this.listimageshow_search_des,
      required this.img_key,
      required this.namekey});

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Image Page รับอะไรมาบ้าง ");

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          //ShowImage(name: title, selectbum: selectbum)
                          Select_Text_Show(
                            word_for_des: this.word_for_des,
                            listimageshow_search_des:
                                this.listimageshow_search_des,
                            keyall: this.keyall,
                          )));
            },
          ),

          /////////////////// แถบบน //////////////////////////////
          title: Text(
            (this.namekey).toString(),
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
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          padding: EdgeInsets.all(8),
          childAspectRatio: 1 / 1.2,
          children: <Widget>[
            if (this.img_key != null)
              if (this.img_key["device"] != null)
                for (int i = 0; i < this.img_key["device"].length; i++)
                  _GridItem(
                    this.namekey,
                    img: this.img_key["device"][i]["img"] as String,
                    onTap: () => checkOption(i + 1),
                    selected: i + 1 == optionSelected,
                    selectbum: i + 1,
                    listimageshow: img_key,
                    status_album: "",
                    listimageshow_search_des: this.listimageshow_search_des,
                    keyall: this.keyall,
                    word_for_des: this.word_for_des,
                  ),
            if (this.img_key != null)
              if (this.img_key["cloud"] != null)
                for (int i = 0; i < this.img_key["cloud"].length; i++)
                  _GridItem_Cloud(
                    this.namekey,
                    img: this.img_key["cloud"][i]["img"] as String,
                    onTap: () => checkOption(i + 1),
                    selected: i + 1 == optionSelected,
                    selectbum: i + 1,
                    listimageshow: img_key,
                    status_album: "",
                    listimageshow_search_des: this.listimageshow_search_des,
                    keyall: this.keyall,
                    word_for_des: this.word_for_des,
                  ),
          ],
        ));
  }
}

class _GridItem_Cloud extends StatelessWidget {
  const _GridItem_Cloud(this.title,
      {Key? key,
      required this.word_for_des,
      required this.listimageshow_search_des,
      required this.keyall,
      required this.img,
      required this.selectbum,
      required this.onTap,
      required this.selected,
      required this.listimageshow,
      required this.status_album})
      : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;
  final listimageshow;
  final status_album;
  final word_for_des;

  final listimageshow_search_des;

  final keyall;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: img,
        imageBuilder: (context, imageProvider) {
          return Ink.image(
            image: imageProvider,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SlideImage_search(
                              title: this.title,
                              selectpicS: img,
                              status: "cloud",
                              word_for_des: this.word_for_des,
                              keyall: this.keyall,
                              img_key: listimageshow,
                              listimageshow_search_des:
                                  this.listimageshow_search_des,
                            )));
                print("รูปรวม ส่งไปที่ รูปใหญ่ : ");
                print(title);
                print(img);
                print(listimageshow);
                print(
                    "///////////////////////////////////////////////////////");
              },
            ),
          );
        });
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem(this.title,
      {Key? key,
      required this.word_for_des,
      required this.listimageshow_search_des,
      required this.keyall,
      required this.img,
      required this.selectbum,
      required this.onTap,
      required this.selected,
      required this.listimageshow,
      required this.status_album})
      : super(key: key);
  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;
  final listimageshow;
  final status_album;
  final word_for_des;
  final listimageshow_search_des;

  final keyall;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      fit: BoxFit.cover,
      image: FileImage(File(img)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SlideImage_search(
                        title: this.title,
                        selectpicS: img,
                        status: "device",
                        word_for_des: this.word_for_des,
                        keyall: this.keyall,
                        img_key: listimageshow,
                        listimageshow_search_des: this.listimageshow_search_des,
                      )));
          print("รูปรวม ส่งไปที่ รูปใหญ่ : ");
          print(title);
          print(img);
          print(listimageshow);
          print("///////////////////////////////////////////////////////");
        },
      ),
    );
  }
}
