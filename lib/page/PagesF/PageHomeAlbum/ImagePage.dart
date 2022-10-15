import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Edit_keyword_des.dart';
//import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImageSliderPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manage_album_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/renameAlbum.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/selectImage_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_client.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_server.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

//enum Menu { itemZero, itemOne, itemTwo, itemThree }

// ignore: must_be_immutable
class ShowImage extends StatefulWidget {
  var name;
  var listimageshow;
  var statusAlbum;
  ShowImage({this.name, this.listimageshow, this.statusAlbum});
  @override
  Allimages createState() => Allimages(
      name: name, listimageshow: listimageshow, statusAlbum: statusAlbum);
}

class Allimages extends State<ShowImage> {
  int optionSelected = 0;
  var statusAlbum;
  var name;
  var listimageshow; //อัลบั้มที่ผู้ใช้เลือก
  Allimages({this.name, this.listimageshow, required this.statusAlbum});

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Image Page รับอะไรมาบ้าง ");
    print(name);
    print(listimageshow);
    return Scaffold(
        appBar: AppBar(
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
                          page: 0,
                          user: user,
                          listimageshow: listimageshow,
                          ListImgCloud: ListImgCloud,
                          AllTagAlbum: ListTag)));
            },
          ),
          title: Text(
            this.name.toString(),
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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.restore,
                color: MyStyle().blackColor,
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
                        builder: (context) =>
                            //ShowImage(name: title, selectbum: selectbum)
                            ShowImage(
                              name: title,
                              listimageshow: showDevice,
                              statusAlbum: this.statusAlbum,
                            )));
                print("เลือกอัลบั้มที่ : ");
                print(title);
                print(showDevice);
                print(
                    "///////////////////////////////////////////////////////");
                /*DBHelper db = DBHelper();
                await db.deletedata_intable();
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstState(
                            page: 0,
                            user: user,
                            listimageshow: listimageshow,
                            ListImgCloud: ListImgCloud)));
             */
              },
            ),
            IconButton(
              icon: Icon(
                Icons.drive_file_move_outline,
                color: MyStyle().blackColor,
              ),
              onPressed: () async {
                List<ImageData> imageListD = [];
                List<ImageData> imageListC = [];
                //imageList = ImageData.getImage();
                for (int i = 0; i < this.listimageshow["device"].length; i++) {
                  ImageData idt = ImageData(
                      this.listimageshow["device"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["device"][i]['nameimg']);
                  imageListD.add(idt);
                }
                //var lenListD = imageListD.length;
                print(imageListD.length);
                print("******00*****");
                for (int i = 0; i < this.listimageshow["cloud"].length; i++) {
                  ImageData idtc = ImageData(
                      this.listimageshow["cloud"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["cloud"][i]['nameimg']);
                  imageListD.add(idtc);
                }
                var lenListC = this.listimageshow["cloud"].length;
                var lenListD = this.listimageshow["device"].length;
                String statusitem = "Don't have";
                if (lenListC != 0 && lenListD != 0) {
                  statusitem = "Have 2";
                } else if (lenListC != 0 && lenListD == 0) {
                  statusitem = "Have 1 Cloud";
                } else if (lenListC == 0 && lenListD != 0) {
                  statusitem = "Have 1 Device";
                }
                print(imageListD.length);
                print("**************************************");
                print(imageListC);
                print(
                    "**************ddddddddddddddddddddddddd************************");
                print(imageListD);
                print("**************************************");
                if (imageListC.length == 0 && imageListD.length == 0) {
                  await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('No image in album'),
                    ),
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectImageHomePage(
                                imageListD: imageListD,
                                lenListC: lenListC,
                                iconselect: "move",
                                statusitem: statusitem,
                                title: this.name,
                                /*iconselect: "delete"*/
                                /*iconselect: "delete"*/
                              )));
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline_outlined,
                color: MyStyle().blackColor,
              ),
              onPressed: () async {
                List<ImageData> imageListD = [];
                List<ImageData> imageListC = [];
                //imageList = ImageData.getImage();
                for (int i = 0; i < this.listimageshow["device"].length; i++) {
                  ImageData idt = ImageData(
                      this.listimageshow["device"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["device"][i]['nameimg']);
                  imageListD.add(idt);
                }
                //var lenListD = imageListD.length;
                print(imageListD.length);
                print("******00*****");
                for (int i = 0; i < this.listimageshow["cloud"].length; i++) {
                  ImageData idtc = ImageData(
                      this.listimageshow["cloud"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["cloud"][i]['nameimg']);
                  imageListD.add(idtc);
                }
                var lenListC = this.listimageshow["cloud"].length;
                var lenListD = this.listimageshow["device"].length;
                String statusitem = "Don't have";
                if (lenListC != 0 && lenListD != 0) {
                  statusitem = "Have 2";
                } else if (lenListC != 0 && lenListD == 0) {
                  statusitem = "Have 1 Cloud";
                } else if (lenListC == 0 && lenListD != 0) {
                  statusitem = "Have 1 Device";
                }
                print(imageListD.length);
                if (imageListC.length == 0 && imageListD.length == 0) {
                  await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('No image in album'),
                    ),
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectImageHomePage(
                                imageListD: imageListD,
                                lenListC: lenListC,
                                iconselect: "Delete",
                                statusitem: statusitem,
                                title: this.name,
                                /*iconselect: "delete"*/
                                /*iconselect: "delete"*/
                              )));
                }
              },
            ),

            ///////// ตั้งค่า ดูข้อมูลอัลบั้ม /////////
            if (statusAlbum == "Usercreate")
              PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: MyStyle().blackColor,
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        const PopupMenuItem(
                          value: 0,
                          child: Text('Album information'),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Change album name'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('Edit keywords'),
                        ),
                        const PopupMenuItem(
                          value: 3,
                          child: Text('Delete albums'),
                        ),
                      ],
                  onSelected: (values) async {
                    //// ดูข้อมูลอัลบั้มทั้งหมด ////
                    if (values == 0) {
                      DBHelper db = new DBHelper();
                      var dataalbum = await db.getData_Album(this.name);
                      print("////");
                      print(dataalbum);

                      print("////");
                      print(dataalbum[0]['IDENTITYALBUM']);
                      if (dataalbum[0]['IDENTITYALBUM'] != "Servercreate") {
                        var description = "";
                        var keyword = "";
                        if (dataalbum[0]['DESCRIPTIONALBUM'].length != 0) {
                          description = dataalbum[0]['DESCRIPTIONALBUM'];
                        }
                        if (dataalbum[0]['KEYWORDALBUM'].length != 0) {
                          //keyword = dataalbum[0]['KEYWORDALBUM'];
                          for (int i = 0;
                              i < dataalbum[0]['KEYWORDALBUM'].length;
                              ++i) {
                            if (dataalbum[0]['KEYWORDALBUM'][i] == "/" &&
                                i < dataalbum[0]['KEYWORDALBUM'].length - 1) {
                              keyword += " , ";
                            } else if (dataalbum[0]['KEYWORDALBUM'][i] != "/") {
                              keyword += dataalbum[0]['KEYWORDALBUM'][i];
                            }
                          }
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    setting_Album_Client(
                                        title: this.name,
                                        description: description,
                                        keyword: keyword)));
                      }
                    }
                    //// เปลี่ยนชื่อ อัลบั้ม /////
                    else if (values == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => rename_album(
                                    name: name,
                                    listimageshow: listimageshow,
                                  )));
                    }
                    //// แก้ไขคีย์เวิร์ด ////
                    else if (values == 2) {
                      DBHelper db = new DBHelper();
                      var dataalbum = await db.getData_Album(this.name);
                      print("////");
                      print(dataalbum);

                      print("////");
                      print(dataalbum[0]['IDENTITYALBUM']);
                      if (dataalbum[0]['IDENTITYALBUM'] != "Servercreate") {
                        var description = "";
                        var keyword = "";
                        var listkeyword = [];
                        if (dataalbum[0]['DESCRIPTIONALBUM'].length != 0) {
                          description = dataalbum[0]['DESCRIPTIONALBUM'];
                        }
                        if (dataalbum[0]['KEYWORDALBUM'].length != 0) {
                          //keyword = dataalbum[0]['KEYWORDALBUM'];
                          for (int i = 0;
                              i < dataalbum[0]['KEYWORDALBUM'].length;
                              ++i) {
                            if (dataalbum[0]['KEYWORDALBUM'][i] == "/") {
                              listkeyword.add(keyword);
                              keyword = "";
                            } else if (dataalbum[0]['KEYWORDALBUM'][i] != "/") {
                              keyword += dataalbum[0]['KEYWORDALBUM'][i];
                            }
                          }
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Edit_keyword_des_album(
                                      description: description,
                                      keyword: listkeyword,
                                      name: this.name,
                                    )));
                      }
                    }
                    //// ลบอัลบั้ม ////
                    else if (values == 3) {
                      print(this.name);
                      AlertDialogs_manage_album.yesCancelDialog(
                          context,
                          'Delete',
                          'are you sure?',
                          this.name,
                          "delete",
                          "",
                          "");
                    }
                  }),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          padding: EdgeInsets.all(8),
          childAspectRatio: 1 / 1.2,
          children: <Widget>[
            if (this.listimageshow != null)
              if (this.listimageshow["device"] != null)
                for (int i = 0; i < this.listimageshow["device"].length; i++)
                  _GridItem(
                    this.listimageshow["device"][i]['Namebum'] as String,
                    img: this.listimageshow["device"][i]['img'] as String,
                    onTap: () => checkOption(i + 1),
                    selected: i + 1 == optionSelected,
                    selectbum: i + 1,
                    listimageshow: listimageshow,
                    keyimg: listimageshow["device"][i]['nameimg'],
                    status_album: this.statusAlbum,
                  ),
            if (this.listimageshow != null)
              if (this.listimageshow["cloud"] != null)
                for (int i = 0; i < this.listimageshow["cloud"].length; i++)
                  _GridItem_Cloud(
                      this.listimageshow["cloud"][i]['Namebum'] as String,
                      img: this.listimageshow["cloud"][i]['img'] as String,
                      onTap: () => checkOption(i + 1),
                      selected: i + 1 == optionSelected,
                      selectbum: i + 1,
                      listimageshow: listimageshow,
                      keyimg: listimageshow["cloud"][i]['nameimg'],
                      status_album: this.statusAlbum),
          ],
        ));
  }
}

int c = 0;

class _GridItem_Cloud extends StatelessWidget {
  const _GridItem_Cloud(this.title,
      {Key? key,
      required this.img,
      required this.selectbum,
      required this.onTap,
      required this.selected,
      required this.keyimg,
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
  final keyimg;
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
                        builder: (context) => SlideImage(
                              namealbumS: title,
                              selectpicS: img,
                              status: "cloud",
                              keyimg: this.keyimg,
                              listimageshow: listimageshow,
                              status_album: status_album,
                            )));
                print("รูปรวม ส่งไปที่ รูปใหญ่ : ");
                print(title);
                print(img);
                print(listimageshow);
                print(
                    "///////////////////////////////////////////////////////");
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                      //textDirection: TextDirection.ltr, //
                      children: <Widget>[
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(221, 20, 147, 185),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.cloud_circle_rounded,
                            color: MyStyle().whiteColor,
                          ),

                          /*Text(
                            "In cloud",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 10),
                          ),*/
                        ),
                      ]),
                ),
              ),
            ),
          );
        });
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem(this.title,
      {Key? key,
      required this.img,
      required this.selectbum,
      required this.onTap,
      required this.selected,
      required this.keyimg,
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
  final keyimg;
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
                  builder: (context) => SlideImage(
                        namealbumS: title,
                        selectpicS: img,
                        keyimg: this.keyimg,
                        status: "device",
                        listimageshow: listimageshow,
                        status_album: status_album,
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
