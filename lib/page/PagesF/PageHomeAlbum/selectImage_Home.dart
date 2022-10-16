import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Move_image.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/delete_img_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manageimage_homt.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';

class SelectImageHomePage extends StatefulWidget {
  var imageListD;
  var title;
  var lenListC;
  var iconselect;
  var statusitem;
  SelectImageHomePage({
    required this.imageListD,
    required this.lenListC,
    required this.iconselect,
    required this.statusitem,
    required this.title,
  });

  @override
  _SelectImageDeviceState createState() => _SelectImageDeviceState(
        imageListD: this.imageListD,
        lenListC: this.lenListC,
        iconselect: this.iconselect,
        statusitem: this.statusitem,
        title: this.title,
      );
}

class _SelectImageDeviceState extends State<SelectImageHomePage> {
  var imageListD;
  var lenListC;
  var iconselect;
  var statusitem;
  var title;
//  var iconselect;
  _SelectImageDeviceState(
      {required this.imageListD,
      required this.lenListC,
      required this.iconselect,
      required this.statusitem,
      required this.title});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("หน้าเลือกแล้วจ้า");
    print(this.imageListD.length);
    print("OOOOOO-----OOOOOO");
    //print(this.imageListC.length);
    print(this.iconselect);
    print("ค่าาาาาา");
    var nameAppBar;
    this.iconselect == 'move'
        ? nameAppBar = 'Select Move'
        : nameAppBar = 'Select Delete';
    return Scaffold(
      appBar: AppBar(
        title: Text(nameAppBar,
            style: TextStyle(
              color: MyStyle().whiteColor,
            )),
        centerTitle: false,
        backgroundColor: MyStyle().blackColor,
        automaticallyImplyLeading: true,
        actions: [
          TextButton(
            child: Text(
              'All Select',
              style: TextStyle(
                color: MyStyle().perpleColorSawang,
              ),
            ),
            onPressed: () async {
              print("/////**/////**");
              int checkk = 0;
              setState(() {
                if (this.imageListD.length != 0) {
                  for (var k = 0; k < this.imageListD.length; k++) {
                    if (this.imageListD[k].isSelected == true) {
                      checkk = checkk + 1;
                    }
                  }
                  for (var i = 0; i < this.imageListD.length; i++) {
                    if (checkk != this.imageListD.length) {
                      this.imageListD[i].isSelected = false;
                    }
                  }

                  for (var i = 0; i < this.imageListD.length; i++) {
                    this.imageListD[i].isSelected =
                        !this.imageListD[i].isSelected;
                  }
                }
              });
              print("จำนวนรูปที่เลือก");
              print(this.imageListD);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_circle_right,
              color: MyStyle().whiteColor,
            ),
            onPressed: () async {
              print("****/////******/////****");

              var status = false;
              var numimg = 0;
              for (int i = 0; i < this.imageListD.length; ++i) {
                if (imageListD[i].isSelected) {
                  status = true;
                  numimg = i;
                }
              }
              if (status) {
                if (iconselect == "Delete") {
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Cloud") {
                    await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:
                            Text('The image your selected have cloud image!'),
                      ),
                    );
                  }
                  if (this.statusitem == "Have 2" &&
                      numimg > (this.imageListD.length - this.lenListC) - 1) {
                    await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:
                            Text('The image your selected have cloud image!'),
                      ),
                    );
                  }

                  await AlertDialogs_Delete_img.yesCancelDialog(context,
                      'Delete', 'Are you sure?', this.title, imageListD);
                } else if (iconselect == "move") {
                  await AlertDialogs_move_img.yesMoveDialog(
                      context, 'move', 'Are you sure?', this.title, imageListD);
                  //   await manage_img.move();
                }
              } else {
                await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('No image select.'),
                  ),
                );
              }
              //  if (imageListC.length != 0) {}
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0),
        itemCount: this.imageListD.length,
        itemBuilder: (builder, index) {
          return InkWell(
              onTap: () {
                if (this.imageListD.length != 0) {
                  setState(() {
                    print(index);
                    this.imageListD[index].isSelected =
                        !this.imageListD[index].isSelected;
                  });
                }
              },
              child: Stack(
                children: [
                  if (this.imageListD.length != 0 &&
                      index <= (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    _getImage(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      index <= (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? MyStyle().faColor
                                  : Color.fromARGB(255, 255, 0, 0),
                              child: Icon(
                                Icons.check,
                                color: MyStyle().whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (this.imageListD.length != 0 &&
                      index > (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    _getImageC(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      index > (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? MyStyle().famonColor
                                  : Color.fromARGB(255, 160, 23, 23),
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Cloud")
                    _getImageC(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Cloud")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 0, 0),
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Device")
                    _getImage(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Device")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 0, 0),
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ));
        },
      ),
    );
  }

  _getImage(url) => Ink.image(
        fit: BoxFit.cover,
        image: FileImage(File(url)),
      );
  _getImageC(url) => Container(
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
                      color: MyStyle().perpleColor,
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
        height: 190.0,
        width: MediaQuery.of(context).size.width - 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: MyStyle().perpleColor,
            image: DecorationImage(
                fit: BoxFit.cover, image: new NetworkImage(url))),
      );
  @override
  void dispose() {
    super.dispose();
  }
}
