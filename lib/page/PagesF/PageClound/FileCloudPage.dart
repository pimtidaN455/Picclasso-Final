import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/OpenFilepick.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/ImageSliderPageClound.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/SelectCloud.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'dart:typed_data';
import 'dart:convert';

import '../first.dart';

class FilePic extends StatefulWidget {
  var ListImgCloud;
  FilePic({required this.ListImgCloud});
  @override
  _MyAppState5 createState() => new _MyAppState5(ListImgCloud: ListImgCloud);
}

class _MyAppState5 extends State<FilePic> {
  var ListImgCloud;
  _MyAppState5({required this.ListImgCloud});

  List<Asset> images = <Asset>[];

  late File newFileNoCash;
  var listimage;
  int optionSelected = 0;
  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  selectImages() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    //allowedExtensions: ['jpg', 'jpeg']);
    print("vvvvvvv");
    print(result);
    print("vvvvvvv");
    if (result == null) {
      return false;
    }
    for (int i = 0; i < result.files.length; i++) {
      print(result.files[i]);
      newFileNoCash = await saveFilePermanently(result.files[i]);
      print('To path : ');
      print(newFileNoCash.path);
      print(result.files[i].name);

      File file = await File(newFileNoCash.path);
      Uint8List bytes = await file.readAsBytesSync();
      String base64Image = await base64Encode(bytes);
      print(await base64Image);
      use_API use_Api = await new use_API();
      //ส่งรูปไปที่ sever
      var addimg_cloud = await use_Api.Addimage_clound(
        await result.files[i].name,
        await newFileNoCash.path,
        await base64Image,
      );
      file.delete();

      print("Pathcache");
      print(result.files[i].path);
      print("Pathcache");

      /*Photo pt = new Photo(i.toString(), result.files[i].name,
          newFileNoCash.path, "keyword", "class");
      print("pt.toStringggggggg");
      print(pt.toString());
      print("******************************");*/

      /*DBHelper db = await DBHelper();
      await db.checkDatabase();
      print("เซฟฟฟฟฟฟฟฟฟฟฟฟโฟโค้วววว");
      await db.savePhoto(await pt);
      openFiles(result.files);
      print("result files หลังจากเลือกรูปแล้ว");
      print(result.files); 
      */
    }

    //openFile(newFile.path);
    /*print('From path : ');
    print(file.path);
    print('To path: ');
    print(newFile);
    print(newFile.path);

    
    print(newFile.uri);*/
    return true;
  }

  void openFiles(List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              FilesPage(files: files, onOpenedFile: openFile)));

  void openFile(PlatformFile newFile) {
    OpenFile.open(newFile.path!);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationSupportDirectory();
    // final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    print('saveFilePermanently :');
    print(appStorage.path);
    print('saveFilePermanently Name :');
    print(file.name);
    return File(file.path!).copy(newFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Text(
              "Clound",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                //fontStyle: FontStyle.normal,
                fontFamily: 'Rajdhani',
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: MyStyle().blackColor,
                  ),
                  onPressed: () async {
                    _MyAppState5 st =
                        new _MyAppState5(ListImgCloud: ListImgCloud);
                    var statusup = await st.selectImages();

                    if (statusup == true) {
                      await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Upload image successfully.'),
                        ),
                      );
                    }
                    user_file user = await new user_file();
                    await user.getdata_user_file();
                    var user0 = await user;
                    var ListImgCloud0;
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
                      if (ListImgCloud != null && ListImgCloud.length != 0) {
                        for (int i = 0; i < ListImgCloud.length; i++) {
                          print(await ListImgCloud[i].geturlimage());
                        }
                      }
                    }

                    var ListTag = [];
                    ManageTag mnt = new ManageTag();
                    ListTag = await mnt.getTagAlbum();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirstState(
                                page: 2,
                                user: user,
                                listimageshow: listimageshow,
                                ListImgCloud: ListImgCloud,
                                AllTagAlbum: ListTag)));
                  }),
              IconButton(
                icon: Icon(
                  Icons.restore,
                  color: MyStyle().blackColor,
                ),
                onPressed: () async {
                  user_file user = await new user_file();
                  await user.getdata_user_file();
                  var user0 = await user;
                  var ListImgCloud0;
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
                  var ListTag = [];
                  ManageTag mnt = new ManageTag();
                  ListTag = await mnt.getTagAlbum();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstState(
                              page: 2,
                              user: user,
                              listimageshow: listimageshow,
                              ListImgCloud: ListImgCloud,
                              AllTagAlbum: ListTag)));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: MyStyle().blackColor,
                ),
                onPressed: () async {
                  List<ImageData> imageList = [];
                  //imageList = ImageData.getImage();
                  if (ListImgCloud != null) {
                    for (int i = 0; i < ListImgCloud.length; i++) {
                      ImageData idt = ImageData(ListImgCloud[i].geturlimage(),
                          false, i, ListImgCloud[i].getnameimage());
                      imageList.add(idt);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SelectImageCloud(imageList: imageList)));
                  } else {
                    await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                            'Cloud has no pictures for you to choose from.'),
                      ),
                    );
                  }
                },
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          body: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: EdgeInsets.all(8),
            childAspectRatio: 1 / 1.2,
            children: <Widget>[
              if (ListImgCloud != null)
                for (int i = 0; i < ListImgCloud.length; i++)
                  _ShowImageCloud(
                    ListImgCloud[i].getnameimage() as String,
                    img: ListImgCloud[i].geturlimage() as String,
                    onTap: () => checkOption(i + 1),
                    selected: i + 1 == optionSelected,
                    selectbum: i + 1,
                  )
            ],
          )),
    );
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

class _ShowImageCloud extends StatelessWidget {
  const _ShowImageCloud(
    this.title, {
    Key? key,
    //required this.nameimg,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  //final String nameimg;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    print("อิมเมจจจจจจจจจจ คาวววววววววว");
    print(img);
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
                        builder: (context) => SlideImageC(
                              namealbumC: title,
                              selectpicC: img,
                            )));
              },
            ));
      },
      placeholder: (context, url) => Container(
          alignment: Alignment.center, child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        return Center(
          child: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}
