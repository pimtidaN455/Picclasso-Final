import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:project_photo_learn/my_style.dart';

import 'package:project_photo_learn/page/PagesF/PageSearch/ShowImage_for_search_.dart';

class SlideImage_search extends StatelessWidget {
  var title;
  var selectpicS;
  var status;

  var word_for_des;
  var keyall;

  var listimageshow_search_des;

  var img_key;

  SlideImage_search({
    required this.title,
    required this.selectpicS,
    required this.status,
    required this.img_key,
    required this.word_for_des,
    required this.listimageshow_search_des,
    required this.keyall,
  });
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: SlideImageD2(
          title: this.title,
          selectpicS: this.selectpicS,
          status: this.status,
          word_for_des: this.word_for_des,
          img_key: this.img_key,
          keyall: this.keyall,
          listimageshow_search_des: this.listimageshow_search_des,
        ),
      );
}

class SlideImageD2 extends StatefulWidget {
  final String title;
  final String selectpicS;

  final String status;

  var word_for_des;
  var keyall;
  var img_key;
  var listimageshow_search_des;

  SlideImageD2({
    required this.title,
    required this.selectpicS,
    required this.status,
    required this.word_for_des,
    required this.img_key,
    required this.listimageshow_search_des,
    required this.keyall,
  });
  @override
  SlideImageDevice createState() => SlideImageDevice(
        title: this.title,
        selectPic: selectpicS,
        status: this.status,
        word_for_des: this.word_for_des,
        keyall: this.keyall,
        img_key: this.img_key,
        listimageshow_search_des: this.listimageshow_search_des,
      );
}

class SlideImageDevice extends State<SlideImageD2>
    with TickerProviderStateMixin {
  final controller = TransformationController();
  late AnimationController controllerReset;
  String title;
  String selectPic;

  String status;
  var word_for_des;
  var keyall;

  var listimageshow_search_des;

  var img_key;

  SlideImageDevice({
    required this.title,
    required this.selectPic,
    required this.status,
    required this.img_key,
    required this.word_for_des,
    required this.listimageshow_search_des,
    required this.keyall,
  });

  @override
  void initState() {
    super.initState();

    controllerReset = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    controller.addListener(() {
      if (controller.value.getMaxScaleOnAxis() >= 3) {
        print('Scale >= 3.0');
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(this.title,
            style: TextStyle(
              color: MyStyle().blackColor,
            )),
        centerTitle: true,
        backgroundColor: MyStyle().whiteColor,
        automaticallyImplyLeading: true,
        actions: [],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowImage_for_search_(
                          word_for_des: this.word_for_des,
                          keyall: this.keyall,
                          listimageshow_search_des:
                              this.listimageshow_search_des,
                          img_key: this.img_key,
                          namekey: this.title)));
            }),
      ),
      body: Center(
          child: InteractiveViewer(
        clipBehavior: Clip.none,
        minScale: 0.5,
        maxScale: 4,
        onInteractionEnd: (details) {
          print('End interaction');
        },
        transformationController: controller,
        child: Stack(children: [
          this.status == 'cloud' ? _getImageC(selectPic) : _getImageD(selectPic)
        ]),
      )));

  _getImageD(url) => Ink.image(
        image: FileImage(File(url)),
      );

  _getImageC(url) => CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Ink.image(image: imageProvider);
      });

  void reset() {
    final animationReset = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(controllerReset);

    animationReset.addListener(() {
      setState(() {
        controller.value = animationReset.value;
      });
    });

    controllerReset.reset();
    controllerReset.forward();
  }
}

class ImageData {
  var imageURL;
  bool isSelected;
  int id;
  var tokenphoto;

  ImageData(this.imageURL, this.isSelected, this.id, this.tokenphoto);
}
