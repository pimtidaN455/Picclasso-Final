import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/Sqfl/Photo.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/place.dart';

class list_album {
  var listimage = [];
  var listimageshow = {};
  var listimageshow_cloud = [];
  var listimageshow_device = [];

  showfirst() {}

  getimagefrom_api() async {
    use_API UseApi = new use_API();
    print('APIIIIIIIIIIIII');
    var imageall = (await UseApi.getPhotoFromAPI());

    if (await imageall == null) {
      return null;
    }
    if ((await imageall.length) != 0) {
      for (var Key in (await imageall.keys)) {
        DBHelper db = DBHelper();
        var db2 = await db.checkDatabase();
        var dataalbum = {
          "NAMEALBUM": await imageall[Key]["datafolder"]["Name"],
          "DESCRIPTIONALBUM": await imageall[Key]["datafolder"]["Description"],
          "IDENTITYALBUM": await imageall[Key]["datafolder"]["Identity"],
          "KEYWORDALBUM": await imageall[Key]["datafolder"]["Keyword"]
        };
        print(dataalbum);
        print("แว๊กกกกกกกกกกกกกกกกกกกกกกกกกกกกกกก");
        await db.saveAlbum(await dataalbum, await db2);

        var check = false;
        if (await imageall[Key].length == 2) {
          print("อิมเมดคีย์");
          print(imageall[Key]);
          for (var photo in (await imageall[Key]["Photo"].keys)) {
            if (check == false) {
              if (await imageall[Key]["Photo"][photo]["status_Cloud_Storage"] ==
                  "True_Don't have device") {
                var mapAlbum = {
                  'Namebum': Key,
                  'img': await UseApi.GetImgCloud(
                      await imageall[Key]["Photo"][photo]["Cloud_Storage"]),
                };
                listimageshow_cloud.add(await mapAlbum);
              } else {
                print(
                    "------------------------]]]]]]]]]]]]]]]][[[[[[[[[[[[[----------------");
                print(Key);
                print(imageall[Key]["Photo"][photo]["AddressImage"]);
                print(
                    "------------------------]]]]]]]]]]]]]]]][[[[[[[[[[[[[----------------");
                var mapAlbum = {
                  'Namebum': Key,
                  'img': await imageall[Key]["Photo"][photo]["AddressImage"],
                };
                listimageshow_device.add(await mapAlbum);
              }

              check = true;
            }
            var keyword_P = " ";
            if ((await imageall[Key]["Photo"][photo]["Keyword"]) != null)
              for (int h = 0;
                  h < (await imageall[Key]["Photo"][photo]["Keyword"]).length;
                  ++h) {
                keyword_P +=
                    await imageall[Key]["Photo"][photo]["Keyword"][h] + "/";
              }
            var des_P = "";
            if (await imageall[Key]["Photo"][photo]["description"] != null)
              for (int h = 0;
                  h <
                      (await imageall[Key]["Photo"][photo]["description"])
                          .length;
                  ++h) {
                des_P +=
                    await imageall[Key]["Photo"][photo]["description"][h] + "/";
              }
            Photo pt = await new Photo(
              photo,
              await imageall[Key]["Photo"][photo]["Namephoto"],
              await imageall[Key]["Photo"][photo]["AddressImage"],
              keyword_P,
              des_P,
              await imageall[Key]["Photo"][photo]["Fixed_Album"].toString(),
              await imageall[Key]["Photo"][photo]["status_Cloud_Storage"],
              Key,
              await imageall[Key]["Photo"][photo]["Cloud_Storage"],
            );
            await db.savePhoto(await pt, await db2);
          }
        }
        check = false;

        if (await imageall[Key].length == 1 &&
            await imageall[Key]["datafolder"]["Identity"] == "Usercreate") {
          var mapAlbum = {
            'Namebum': Key,
            'img': "https://static.thenounproject.com/png/3674270-200.png",
            //"https://media.istockphoto.com/vectors/no-image-available-icon-vector-id1216251206",
          };
          listimageshow_cloud.add(await mapAlbum);
        }
      }
    }
    listimageshow["device"] = listimageshow_device;
    listimageshow["cloud"] = listimageshow_cloud;

    return await listimage;
  }

  getimagefrom_api_No_Cloud() async {
    use_API UseApi = new use_API();
    print('APIIIIIIIIIIIII');
    var imageall = (await UseApi.getPhotoFromAPI());
    //print((await UseApi.getPhotoFromAPI()).runtimeType);

    if (await imageall == null) {
      return null;
    }
    if ((await imageall.length) != 0) {
      for (var Key in (await imageall.keys)) {
        DBHelper db = DBHelper();
        var db2 = await db.checkDatabase();
        var dataalbum = {
          "NAMEALBUM": await imageall[Key]["datafolder"]["Name"],
          "DESCRIPTIONALBUM": await imageall[Key]["datafolder"]["Description"],
          "IDENTITYALBUM": await imageall[Key]["datafolder"]["Identity"],
          "KEYWORDALBUM": await imageall[Key]["datafolder"]["Keyword"]
        };
        print(dataalbum);
        print("แว๊กกกกกกกกกกกกกกกกกกกกกกกกกกกกกกก");
        await db.saveAlbum(await dataalbum, await db2);

        var check = false;
        if (await imageall[Key]["datafolder"]["Identity"] == "Usercreate") {
          if (await imageall[Key].length == 2) {
            print("อิมเมดคีย์");
            print(imageall[Key]);
            for (var photo in (await imageall[Key]["Photo"].keys)) {
              if (check == false) {
                if (await imageall[Key]["Photo"][photo]
                        ["status_Cloud_Storage"] ==
                    "True_Don't have device") {
                  var mapAlbum = {
                    'Namebum': Key,
                    'img': await UseApi.GetImgCloud(
                        await imageall[Key]["Photo"][photo]["Cloud_Storage"]),
                  };
                  listimageshow_cloud.add(await mapAlbum);
                } else {
                  print(
                      "------------------------]]]]]]]]]]]]]]]][[[[[[[[[[[[[----------------");
                  print(Key);
                  print(imageall[Key]["Photo"][photo]["AddressImage"]);
                  print(
                      "------------------------]]]]]]]]]]]]]]]][[[[[[[[[[[[[----------------");
                  var mapAlbum = {
                    'Namebum': Key,
                    'img': await imageall[Key]["Photo"][photo]["AddressImage"],
                  };
                  listimageshow_device.add(await mapAlbum);
                }

                check = true;
              }
              var keyword_P = " ";
              if ((await imageall[Key]["Photo"][photo]["Keyword"]) != null)
                for (int h = 0;
                    h < (await imageall[Key]["Photo"][photo]["Keyword"]).length;
                    ++h) {
                  keyword_P +=
                      await imageall[Key]["Photo"][photo]["Keyword"][h] + "/";
                }
              var des_P = "";
              if (await imageall[Key]["Photo"][photo]["description"] != null)
                for (int h = 0;
                    h <
                        (await imageall[Key]["Photo"][photo]["description"])
                            .length;
                    ++h) {
                  des_P += await imageall[Key]["Photo"][photo]["description"]
                          [h] +
                      "/";
                }
              Photo pt = await new Photo(
                photo,
                await imageall[Key]["Photo"][photo]["Namephoto"],
                await imageall[Key]["Photo"][photo]["AddressImage"],
                keyword_P,
                des_P,
                await imageall[Key]["Photo"][photo]["Fixed_Album"].toString(),
                await imageall[Key]["Photo"][photo]["status_Cloud_Storage"],
                Key,
                await imageall[Key]["Photo"][photo]["Cloud_Storage"],
              );
              await db.savePhoto(await pt, await db2);
            }
          }
          check = false;

          if (await imageall[Key].length == 1 &&
              await imageall[Key]["datafolder"]["Identity"] == "Usercreate") {
            var mapAlbum = {
              'Namebum': Key,
              'img': "https://static.thenounproject.com/png/3674270-200.png",
              //"https://media.istockphoto.com/vectors/no-image-available-icon-vector-id1216251206",
            };
            listimageshow_cloud.add(await mapAlbum);
          }
        }
      }
    }
    listimageshow["device"] = listimageshow_device;
    listimageshow["cloud"] = listimageshow_cloud;

    return await listimage;
  }

  getImag_inAlbum(var title) async {
    DBHelper db = DBHelper();
    //await db.deletedata_intable();
    use_API UseApi = new use_API();
    print('APIIIIIIIIIIIII');

    var showDevice = await db.getPhotoinAlbum(title);
    print("*******************");
    print(showDevice.length);
    print(showDevice);
    print("****************");
    if (showDevice.length != 0) {
      for (int i = 0; i < showDevice.length; i++) {
        if (showDevice[i]["statuscloud"] == "True_Don't have device") {
          var mapAlbum = {
            'Namebum': title,
            'img':
                await UseApi.GetImgCloud(await showDevice[i]["Cloud_Storage"]),
            'nameimg': showDevice[i]["id"],
          };
          listimageshow_cloud.add(await mapAlbum);
        } else {
          var mapAlbum = {
            'Namebum': title,
            'img': showDevice[i]["photopath"],
            'nameimg': showDevice[i]["id"],
          };
          listimageshow_device.add(await mapAlbum);
        }
      }
      print(listimageshow_cloud);
      print(listimageshow_device);
    }
    listimageshow["device"] = listimageshow_device;
    listimageshow["cloud"] = listimageshow_cloud;

    return await listimageshow;
  }

  getimagefrom_apilogin(var token) async {
    use_API UseApi = new use_API();
    print('APIIIIIIIIIIIII');
    print('GGGGGGGOOOOOOOOOOOOPPPPPPPPPPPPPPPPAPIII');
    print(token);
    var imageall = (await UseApi.getPhotoFromAPIlogin(token));
    //print((await UseApi.getPhotoFromAPI()).runtimeType);
    var check = false;
    if ((await imageall) != null && (await imageall.length) != 0) {
      for (var Key in (await imageall.keys)) {
        print(
            "<<<<<<<<<<<<<<<<<<<<< ตียยยยยยยยยยยยย์ >>>>>>>>>>>>>>>>>>>>>>>>>>>");
        print(Key);
        DBHelper db = DBHelper();
        // await db.deletedata_intable();
        var db2 = await db.checkDatabase();
        var dataalbum = {
          "NAMEALBUM": await imageall[Key]["datafolder"]["Name"],
          "DESCRIPTIONALBUM": await imageall[Key]["datafolder"]["Description"],
          "IDENTITYALBUM": await imageall[Key]["datafolder"]["Identity"],
          "KEYWORDALBUM": await imageall[Key]["datafolder"]["Keyword"]
        };
        await db.saveAlbum(await dataalbum, await db2);

        if (await imageall[Key].length == 2) {
          print("อิมเมดคีย์");
          print(imageall[Key]);
          for (var photo in (await imageall[Key]["Photo"].keys)) {
            if (check == false) {
              if (await imageall[Key]["Photo"][photo]["status_Cloud_Storage"] ==
                  "True_Don't have device") {
                var mapAlbum = {
                  'Namebum': Key,
                  'img': await UseApi.GetImgCloud(
                      await imageall[Key]["Photo"][photo]["Cloud_Storage"]),
                };
                listimageshow_cloud.add(await mapAlbum);
              } else {
                print(
                    "------------------------]]]]]]]]]]]]]]]][[[[[[[[[[[[[----------------");
                print(Key);
                print(imageall[Key]["Photo"][photo]["AddressImage"]);
                print(
                    "------------------------]]]]]]]]]]]]]]]][[[[[[[[[[[[[----------------");
                var mapAlbum = {
                  'Namebum': Key,
                  'img': await imageall[Key]["Photo"][photo]["AddressImage"],
                };
                listimageshow_device.add(await mapAlbum);
              }

              check = true;
            }

            Photo pt = await new Photo(
                photo,
                await imageall[Key]["Photo"][photo]["Namephoto"],
                await imageall[Key]["Photo"][photo]["AddressImage"],
                await imageall[Key]["Photo"][photo]["Keyword"].toString(),
                await imageall[Key]["Photo"][photo]["description"].toString(),
                await imageall[Key]["Photo"][photo]["Fixed_Album"].toString(),
                await imageall[Key]["Photo"][photo]["status_Cloud_Storage"],
                await imageall[Key]["Photo"][photo]["Cloud_Storage"],
                Key);
            await db.savePhoto(await pt, await db2);
          }
        }
        check = false;
        if (await imageall[Key].length == 1 &&
            await imageall[Key]["datafolder"]["Identity"] == "Usercreate") {
          var mapAlbum = {
            'Namebum': Key,
            'img': "https://static.thenounproject.com/png/3674270-200.png",
            //"https://media.istockphoto.com/vectors/no-image-available-icon-vector-id1216251206",
          };
          listimageshow_cloud.add(await mapAlbum);
        }
      }
    }
    listimageshow["device"] = listimageshow_device;
    listimageshow["cloud"] = listimageshow_cloud;

    return await listimage;
  }
}
