import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Editkeyword_img.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/HomePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Move_image.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/delete_img_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

class SlideImage extends StatelessWidget {
  final String title = 'Interactive Viewer';
  var namealbumS;
  var selectpicS;
  var listimageshow;
  var status;
  var status_album;
  var keyimg;
  SlideImage(
      {required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required this.status,
      required this.keyimg,
      required this.status_album});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        home: SlideImageD2(
            title: title,
            namealbumS: this.namealbumS,
            selectpicS: this.selectpicS,
            listimageshow: this.listimageshow,
            keyimg: this.keyimg,
            status: this.status,
            status_album: this.status_album),
      );
}

class SlideImageD2 extends StatefulWidget {
  final String title;
  final String namealbumS;
  final String selectpicS;
  final listimageshow;
  final String status;
  final status_album;

  final keyimg;
  const SlideImageD2(
      {required this.title,
      required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required this.status,
      required this.status_album,
      required this.keyimg});
  @override
  SlideImageDevice createState() => SlideImageDevice(
      title: namealbumS,
      selectPic: selectpicS,
      listimageshow: this.listimageshow,
      status: this.status,
      keyimg: this.keyimg,
      status_album: this.status_album);
}

class SlideImageDevice extends State<SlideImageD2>
    with TickerProviderStateMixin {
  final controller = TransformationController();
  late AnimationController controllerReset;
  String title;
  String selectPic;
  final listimageshow;
  String status;
  var status_album;

  var keyimg;
  SlideImageDevice(
      {required this.title,
      required this.selectPic,
      required this.listimageshow,
      required this.status,
      required this.status_album,
      required this.keyimg});

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.drive_file_move_outline,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              ImageData img =
                  new ImageData(this.selectPic, true, 0, this.keyimg);
              var imageselect = [];
              imageselect.add(img);
              await AlertDialogs_move_img.yesMoveDialog(
                  context, 'move', 'are you sure?', this.title, imageselect);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: MyStyle().deleteColor,
            ),
            onPressed: () async {
              ImageData img =
                  new ImageData(this.selectPic, true, 0, this.keyimg);
              var imageselect = [];
              imageselect.add(img);
              await AlertDialogs_Delete_img.yesCancelDialog(
                  context, 'Delete', 'are you sure?', this.title, imageselect);
/*
              title; //ชื่อรูปคลาว
              selectPic; //ลิ้งค์รูปคาว*/
            },
          ),
          if (this.status_album == "Usercreate" ||
              this.title == "Document+Education")
            IconButton(
              icon: Icon(
                Icons.settings,
                color: MyStyle().blackColor,
              ),
              onPressed: () async {
                DBHelper db = new DBHelper();

                var photodata = await db.getPhoto_from_id(this.keyimg);
                print("///////////////////*****////////////////////");
                print(this.keyimg);
                print(photodata);
                var keyword = "";
                var listkeyword = [];
                for (int i = 0; i < photodata[0]['photokeyword'].length; ++i) {
                  if (photodata[0]['photokeyword'][i] != '/') {
                    keyword += photodata[0]['photokeyword'][i];
                  } else {
                    listkeyword.add(keyword);
                    keyword = "";
                  }
                }
                print(listkeyword);
                //for(int i =0 ; i< )
                print("///////////////////*****////////////////////");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Edit_keyword_img(
                            keyword: listkeyword,
                            namealbumS: this.title,
                            selectpicS: this.selectPic,
                            listimageshow: this.listimageshow,
                            keyimg: this.keyimg,
                            status: this.status,
                            status_album: this.status_album)));

                //  ua.saveImage(selectpicC);

                //namealbumC; //ชื่อรูปคลาว
                //selectpicC; //ลิ้งค์รูปคาว
              },
            ),
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              /*
              user_file user0 = new user_file();

              await user0.getdata_user_file();
              var user = await user0;
              var ListImgCloud;
              var listimageshow;

              //
              if (await user.Login) {
                list_album la = await new list_album();
                await la.getimagefrom_api();
                print(
                    'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                listimageshow = await la.listimageshow;

                listimagecloud listimgC = await new listimagecloud();
                ListImgCloud = await listimgC.getimagefrom_api();
                print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                /*  if (ListImgCloud != null && ListImgCloud.length != 0) {
                  for (int i = 0; i < ListImgCloud.length; i++) {
                    print(await ListImgCloud[i].geturlimage());
                  }
                }*/
              }*/

              var Request_page = ShowImage(
                  name: title,
                  listimageshow: this.listimageshow,
                  statusAlbum: this.status_album);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Request_page));
              print("ส่งชื่ออัลบั้มไปที่ ShowImage" + this.title);
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
