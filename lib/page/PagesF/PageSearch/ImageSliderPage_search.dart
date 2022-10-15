import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/HomePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Move_image.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/delete_img_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/ShowImage_for_search_.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

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
/*
  static List<ImageData> getImage() {
    return [
      ImageData('https://picsum.photos/200', false, 1),
      ImageData('https://picsum.photos/100', false, 2),
      ImageData('https://picsum.photos/300', false, 3),
      ImageData('https://picsum.photos/400', false, 4),
      ImageData('https://picsum.photos/500', false, 5),
      ImageData('https://picsum.photos/600', false, 6),
      ImageData('https://picsum.photos/700', false, 7),
      ImageData('https://picsum.photos/800', false, 8),
      ImageData('https://picsum.photos/900', false, 9),
    ];
  }*/
}

/*import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';

// ignore: must_be_immutable
class SlideImage extends StatelessWidget {
  String title;
  int selectPic;
  SlideImage({required this.title, required this.selectPic});

  Widget build(BuildContext context) {
    print("selecpic ที่รับมาจาก Imageplace");
    print(this.selectPic);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(this.title,
            style: TextStyle(
              color: MyStyle().blackColor,
            )),
        centerTitle: true,
        backgroundColor: MyStyle().whiteColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyStyle().blackColor,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowImage(name: this.title)));
            print("ส่งชื่ออัลบั้มไปที่ ShowImage" + this.title);
          },
        ),
      ),
      body: Body(selectPic: selectPic),
    ));
  }
}

// ignore: must_be_immutable
class Body extends StatefulWidget {
  int selectPic;
  Body({required this.selectPic});
  @override
  State<Body> createState() => _Body(currentIndex: selectPic);
}

class _Body extends State<Body> {
  int currentIndex;
  _Body({required this.currentIndex});
  //int selectPic1 = 0;
  PageController controller = PageController();
  List<String> imagelist = [
    './images/sangcom1.png',
    './images/sangcom2.png',
    './images/sangcom3.jpg',
    './images/sangcom4.jpg',
    './images/sangcom5.jpg',
    './images/sangcom6.png',
    './images/sangcom7.png',
    './images/sangcom8.png',
    './images/sangcom9.png',
    './images/sangcom10.png'
  ];

  @override
  Widget build(BuildContext context) {
    print("+++++++++++++++++++++++++++++++++++++++++++++++++");
    print(currentIndex);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 500,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              //////////////////////////////////////////////
              onPageChanged: (index) {
                print("index : ");
                print(index);
                setState(() {
                  ////////////////////////////////////////////
                  currentIndex = index % imagelist.length;
                });
              },
              //////////////////////////////////////
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Image.asset(
                      ///////////////////////////////////////////////////////////////
                      imagelist[currentIndex % imagelist.length],
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              for (var i = 0; i < imagelist.length; i++)
                buildIndicator(currentIndex == i)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    print("ค่าเปลี่ยนนหน้า ก่อน ถอยหลัง = ");
                    print(currentIndex);
                    controller.jumpToPage(currentIndex - 1);
                    print("ค่าเปลี่ยนนหน้า หลัง ถอยหลัง = ");
                    print(currentIndex);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    print("ค่าเปลี่ยนนหน้า ก่อน เดินหน้า = ");
                    print(currentIndex);
                    controller.jumpToPage(currentIndex + 1);
                    print("ค่าเปลี่ยนนหน้า หลัง เดินหน้า = ");
                    print(currentIndex);
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
 */
