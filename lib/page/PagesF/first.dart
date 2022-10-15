import 'package:flutter/material.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/HomePage.dart';
import 'package:project_photo_learn/page/PagesF/PagePerson/PersonPage2.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/SearchPage.dart';

// ignore: must_be_immutable
class FirstState extends StatefulWidget {
  //const FirstState({Key? key, required int count}) : super(key: key);
  int page;
  var user;
  var ListImgCloud;
  var listimageshow;
  var AllTagAlbum;

  FirstState(
      {required this.page,
      required this.user,
      required this.ListImgCloud,
      required this.listimageshow,
      required this.AllTagAlbum});

  @override
  _FirstState createState() => _FirstState(
      index: page,
      user: user,
      listimageshow: this.listimageshow,
      ListImgCloud: this.ListImgCloud,
      AllTagAlbum: this.AllTagAlbum);
}

class _FirstState extends State<FirstState> {
  int index;
  var user;
  var ListImgCloud;
  var listimageshow;
  var AllTagAlbum;
  _FirstState(
      {required this.index,
      required this.user,
      required this.ListImgCloud,
      required this.listimageshow,
      required this.AllTagAlbum});

  Widget build(BuildContext context) {
    print("Gets");
    final Screen = [
      Homepage(
          user: user,
          listimageshow: listimageshow,
          ListImgCloud: ListImgCloud,
          AllTagAlbum: AllTagAlbum),
      Searchpage(AllTagAlbum: AllTagAlbum),
      FilePic(ListImgCloud: ListImgCloud),
      Person_page1(user: user)
    ];

    return Scaffold(
        body: Screen[index],
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                //indicatorColor: Colors.black,
                labelTextStyle:
                    MaterialStateProperty.all(TextStyle(fontSize: 14))),
            child: NavigationBar(
              height: 60,
              //backgroundColor: Colors.blue,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),

              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(
                    icon: Icon(Icons.search), label: "Search"),
                NavigationDestination(icon: Icon(Icons.cloud), label: "Cloud"),
                NavigationDestination(
                    icon: Icon(Icons.person), label: "Person"),
              ],
            )));
  }
}
