// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Edit_Album.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/AddAlbumPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ManageHomePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manage_album_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DeleteAlbums extends StatefulWidget {
  var user;
  var listimageshow;
  var ListImgCloud;
  DeleteAlbums(
      {required this.user,
      required this.listimageshow,
      required this.ListImgCloud});
  @override
  AlbumScreenWidget createState() => AlbumScreenWidget(
      user: user,
      listimageshow: this.listimageshow,
      ListImgCloud: this.ListImgCloud);
}

class AlbumScreenWidget extends State<DeleteAlbums> {
  var user;
  var listimageshow;
  var ListImgCloud;
  AlbumScreenWidget(
      {required this.user,
      required this.listimageshow,
      required this.ListImgCloud});

  int optionSelected = 0;
  late int selectbum;
  void checkOption(int index) {
    print("Home");
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Home");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyStyle().whiteColor,
          title: Text(
            "Delete Album",
            style: TextStyle(
              fontSize: 30,
              color: MyStyle().blackColor,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
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
          automaticallyImplyLeading: false,
        ),
        body: GridView.extent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.all(8),
          childAspectRatio: 1 / 1.2,
          children: <Widget>[
            if (this.listimageshow != null)
              if (this.listimageshow["device"] != null)
                for (int i = 0; i < this.listimageshow["device"].length; i++)
                  _GridItem_Devoce(
                      this.listimageshow["device"][i]['Namebum'] as String,
                      img: this.listimageshow["device"][i]['img'] as String,
                      onTap: () => checkOption(i + 1),
                      selected: i + 1 == optionSelected,
                      selectbum: i + 1,
                      listimageshow: listimageshow),
            if (this.listimageshow != null)
              if (this.listimageshow["cloud"] != null)
                for (int i = 0; i < this.listimageshow["cloud"].length; i++)
                  _GridItem_Cloud(
                    this.listimageshow["cloud"][i]['Namebum'] as String,
                    img: this.listimageshow["cloud"][i]['img'] as String,
                    onTap: () => checkOption(i + 1),
                    selected: i + 1 == optionSelected,
                    selectbum: i + 1,
                  ),
          ],
        ));
  }
}

class _GridItem_Cloud extends StatelessWidget {
  const _GridItem_Cloud(
    this.title, {
    Key? key,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    print("อิมเมจจจจจจจจจจ");
    print(title);
    print(img);
    return CachedNetworkImage(
      imageUrl: img,
      imageBuilder: (context, imageProvider) {
        return Ink.image(
            image: imageProvider,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () async {
                AlertDialogs_manage_album.yesCancelDialog(context, 'Delete',
                    'are you sure?', this.title, "delete", "", "Select_Delete");
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  /*decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ?? false ? Colors.red : Colors.transparent,
                  width: selected ?? false ? 5 : 0,
                ),
              ),
            ),*/
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ]),
                ),
              ),
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

class _GridItem_Devoce extends StatelessWidget {
  const _GridItem_Devoce(
    this.title, {
    Key? key,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
    required this.listimageshow,
  }) : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;
  final listimageshow;

  @override
  Widget build(BuildContext context) {
    print("อิมเมจจจจจจจจจจ");
    print(title);
    print(img);
    return Ink.image(
      fit: BoxFit.cover,
      image: FileImage(File(img)),
      //image: AssetImage(img),
      child: InkWell(
        onTap: () async {
          AlertDialogs_manage_album.yesCancelDialog(context, 'Delete',
              'are you sure?', this.title, "delete", "", "Select_Delete");
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            /*decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ?? false ? Colors.red : Colors.transparent,
                  width: selected ?? false ? 5 : 0,
                ),
              ),
            ),*/
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
