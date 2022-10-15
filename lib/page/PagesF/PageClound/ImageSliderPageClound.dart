import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/Sqfl/Photo.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/deletecloud.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';

class SlideImageC extends StatelessWidget {
  final String title = 'Interactive Viewer';
  var namealbumC; //ชื่อรูปภาพ
  var selectpicC; //รูปภาพ
  SlideImageC({required this.namealbumC, required this.selectpicC});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        home: SlideImageC2(
            title: title,
            namealbumC: this.namealbumC,
            selectpicC: this.selectpicC),
      );
}

class SlideImageC2 extends StatefulWidget {
  final String title;
  final String namealbumC;
  final String selectpicC;
  const SlideImageC2(
      {required this.title,
      required this.namealbumC,
      required this.selectpicC});

  @override
  _MainPageState createState() =>
      _MainPageState(namealbumC: namealbumC, selectpicC: selectpicC);
}

class _MainPageState extends State<SlideImageC2> with TickerProviderStateMixin {
  final controller = TransformationController();
  late AnimationController controllerReset;
  final String namealbumC;
  final String selectpicC;

  _MainPageState({required this.namealbumC, required this.selectpicC});

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
            title: Text("Cloud",
                style: TextStyle(
                  color: MyStyle().blackColor,
                )),
            centerTitle: false,
            backgroundColor: MyStyle().whiteColor,
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.file_download_outlined,
                  color: MyStyle().blackColor,
                ),
                onPressed: () async {
                  //  ua.saveImage(selectpicC);
                  print(selectpicC);
                  final tempDir = await getTemporaryDirectory();
                  final path = '${tempDir.path}/myfile.png';
                  await Dio().download(selectpicC, path);
                  await ImageGallerySaver.saveFile(path);
                  await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Download image successfully'),
                    ),
                  );

                  //namealbumC; //ชื่อรูปคลาว
                  //selectpicC; //ลิ้งค์รูปคาว
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: MyStyle().deleteColor,
                ),
                onPressed: () async {
                  ImageData img =
                      new ImageData(selectpicC, true, 0, namealbumC);
                  var imageselect = [];
                  imageselect.add(img);
                  await AlertDialogs_delete_cloud.yesCancelDialog(
                      context, 'Delete', 'are you sure?', imageselect);
/*
                  namealbumC; //ชื่อรูปคลาว
                  selectpicC; //ลิ้งค์รูปคาว
                  use_API api = new use_API();
                  await api.Delete_image_incloud(namealbumC);
                  print(selectpicC);
                  print(namealbumC);
                  DBHelper db = new DBHelper();
                  await db.deletedata_intable();
                  user_file user = await new user_file();
                  await user.getdata_user_file();
                  var user0 = await user;
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
                    /*for (int i = 0; i < ListImgCloud.length; i++) {
                      print(await ListImgCloud[i].geturlimage());
                    }*/
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstState(
                              page: 2,
                              user: user,
                              listimageshow: listimageshow,
                              ListImgCloud: ListImgCloud)));
                  /*  api.Delete_image_incloud();*/*/
                },
              ),
            ],
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: MyStyle().blackColor,
                ),
                onPressed: () async {
                  user_file user0 = new user_file();

                  await user0.getdata_user_file();
                  var user = await user0;
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilePic(
                                ListImgCloud: ListImgCloud,
                              )));
                  print("ส่งชื่ออัลบั้มไปที่ ShowImage" + this.namealbumC);
                })),
        body: Center(
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            //boundaryMargin: EdgeInsets.all(0),
            minScale: 0.5,
            maxScale: 4,
            //scaleEnabled: false,
            //constrained: false,
            //onInteractionStart: (details) => print('Start interaction'),
            //onInteractionUpdate: (details) => print('Update interaction'),
            onInteractionEnd: (details) {
              print('End interaction');
              //reset();
            },
            transformationController: controller,

            child: CachedNetworkImage(
              imageUrl: selectpicC,
            ),
          ),
        ),
      );

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

    /*setState(() {
      controller.value = Matrix4.identity();
    });
  }*/
  }
}

class ImageData {
  String imageURL;
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
