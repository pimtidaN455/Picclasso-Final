import 'package:project_photo_learn/page/Backend/Use_Api.dart';

class imagecloud {
  var nameimage = "";
  var urlimage = "";

  imagecloud(namimage, urlimage) {
    this.nameimage = nameimage;
    this.urlimage = urlimage;
  }
  getnameimage() {
    return nameimage;
  }

  geturlimage() {
    return urlimage;
  }

  gettoString() {
    return "name:" + nameimage + ' Url:' + urlimage;
  }
}

/*
var lisimage = getimagefrom_api2();
getimagefrom_api2() async {
  var listimage = [];
  use_API use_api = use_API();
  print("------------------------------");
  var imageall = await use_api.getallimage_clound();

  print(imageall['-NC5Mc1HMehAtFBkMi4G']);

  for (var image in imageall.keys) {
    imagecloud img = new imagecloud(image, imageall[image]['Url_photo']);
    img.nameimage = image;
    listimage.add(img);
  }

  for (int i = 0; i < listimage.length; ++i) {
    print(listimage[i].gettoString());
  }
  return await listimage;
}
*/
class listimagecloud {
  var listimage = [];

  getimagefrom_api() async {
    use_API use_api = use_API();
    print("------------------------------");
    var imageall = await use_api.getallimage_clound();
    if (imageall == null) {
      return null;
    }
    if (imageall.length != 0) {
      for (var image in imageall.keys) {
        imagecloud img = new imagecloud(image, imageall[image]['Url_photo']);
        img.nameimage = image;
        listimage.add(img);
      }

      for (int i = 0; i < listimage.length; ++i) {
        print(listimage[i].gettoString());
      }
      return await listimage;
    }
  }
}

class manage_imagecloud {
  delete_imagecloud(var listimage) {
    use_API api = new use_API();

    for (int i = 0; i < listimage.length; ++i) {
      api.Delete_image_incloud(listimage[i].tokenphoto);
      print("ลบอันนี้ ส่ง token อันนี้ค่าาา");
      print(listimage[i].tokenphoto);
    }
  }
}
