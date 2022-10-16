import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Edit_Album.dart';

class use_API {
  var path = "https://127.0.0.1:8000/";

  use_API() {}

  Sign_up(email, password, firstname, lastname) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/signupuser/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': await email,
        'password': await password,
        'firstname': await firstname,
        'lastname': await lastname
      }),
    );
    //  print("KKKKKKKKKK");
    print(response.statusCode);
    // print("DDDDDDDDDDD");

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Login(email, password, id_device) async {
    /// print("UUUUUUUUUUUUUUUUUUUUU");
    print(email);
    print(password);
    print(id_device);
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/loginN/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': await email,
        'password': await password,
        'id_device': await id_device,
      }),
    );
    // print("KKKKKKKKKK");
    //  print(response.statusCode);
    // print("DDDDDDDDDDD");

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
    //audrapunzel@gmail.com
  }

  Logout(tokenID) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/logout/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await tokenID,
      }),
    );
    // print("KKKKKKKKKK");
    //  print(response.statusCode);
    // print("DDDDDDDDDDD");
//
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  GetImgCloud(imageID) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/UrlImgCloud/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'imageID': await imageID
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Change_Album(var idphotho, var nameoldalbum, var namenewalbum) async {
    print("////////////////");
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/change_Album/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'idphoto': idphotho,
        'nameoldalbum': nameoldalbum,
        'namenewalbum': namenewalbum,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Reset_password(email) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/resetpassword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': await email,
      }),
    );
    // // print("KKKKKKKKKK");
    //  print(response.statusCode);
    //  print("DDDDDDDDDDD");

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getdata_from_Server(tokenID) {
    var path_API = path + "DatabeasesendtoUser/";
    var data = {'tokenID': tokenID};
    return http.post(Uri.parse(path_API), body: data);
  }

  update_name(tokenID, Firstname, Lastname) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/userdataupdate/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await tokenID,
        'firstname': await Firstname,
        'lastname': await Lastname
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  detect_word(word) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/detectword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'word': word,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print((jsonDecode(response.body))['message']);
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  manage_Album(namealbum, nameoldalbum, keyword, description, status) async {
    print("////////////////");
    print(namealbum);
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Album/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'namealbum': namealbum,
        'nameoldalbum': nameoldalbum,
        'keyword': keyword,
        'description': description,
        'status': status
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Addimage_clound(nameimage, pathinmage, dataimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Addcloud_storage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'nameimage': await nameimage,
        'image': await dataimage,
        'AddressImage': await pathinmage,
        'datephoto': await now.toString(),
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //   print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getverify_email(var tokenUser) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/send_verified_email/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': tokenUser}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getallimage_clound() async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/imagecloudstorage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': await user_file_.IDuser}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  AddPhoto(nameimage, pathinmage, dataimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/uploadImage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'nameimage': await nameimage,
        'image': await dataimage,
        'AddressImage': await pathinmage,
        'datephoto': await now.toString(),
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  updatekeyword_image(namealbum, nameimg, keyword) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/updatekeyword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'tokenID': await user_file_.IDuser,
        'namealbum': namealbum,
        'imageID': nameimg,
        'keyword': keyword
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getPhotoFromAPI() async {
    user_file user_file_ = await new user_file();
    print("Getphoto");
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/DataAlbum/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': await user_file_.IDuser}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  saveImage(String url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
          "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }

  getPhotoFromAPIlogin(var token) async {
    //user_file user_file_ = await new user_file();
    //await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/DataAlbum/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': token}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Delete_image_incloud(var tokenimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Deletephoto_cloud/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'idimage': await tokenimage,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Delete_image_incHome(var tokenimage, var nameAlbum) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Deletedataphoto/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'namealbum': nameAlbum,
        'idphoto': await tokenimage,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}


/*
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/Edit_Album.dart';

class use_API {
  var path = "https://127.0.0.1:8000/";

  use_API() {}

  Sign_up(email, password, firstname, lastname) async {
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/signupuser/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': await email,
        'password': await password,
        'firstname': await firstname,
        'lastname': await lastname
      }),
    );
    //  print("KKKKKKKKKK");
    print(response.statusCode);
    // print("DDDDDDDDDDD");

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Login(email, password, id_device) async {
    /// print("UUUUUUUUUUUUUUUUUUUUU");
    print(email);
    print(password);
    print(id_device);
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/loginN/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': await email,
        'password': await password,
        'id_device': await id_device,
      }),
    );
    // print("KKKKKKKKKK");
    //  print(response.statusCode);
    // print("DDDDDDDDDDD");

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
    //audrapunzel@gmail.com
  }

  Logout(tokenID) async {
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/logout/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await tokenID,
      }),
    );
    // print("KKKKKKKKKK");
    //  print(response.statusCode);
    // print("DDDDDDDDDDD");
//
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  GetImgCloud(imageID) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/UrlImgCloud/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'imageID': await imageID
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Change_Album(var idphotho, var nameoldalbum, var namenewalbum) async {
    print("////////////////");
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/change_Album/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'idphoto': idphotho,
        'nameoldalbum': nameoldalbum,
        'namenewalbum': namenewalbum,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Reset_password(email) async {
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/resetpassword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': await email,
      }),
    );
    // // print("KKKKKKKKKK");
    //  print(response.statusCode);
    //  print("DDDDDDDDDDD");

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getdata_from_Server(tokenID) {
    var path_API = path + "DatabeasesendtoUser/";
    var data = {'tokenID': tokenID};
    return http.post(Uri.parse(path_API), body: data);
  }

  update_name(tokenID, Firstname, Lastname) async {
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/userdataupdate/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await tokenID,
        'firstname': await Firstname,
        'lastname': await Lastname
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  detect_word(word) async {
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/detectword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'word': word,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print((jsonDecode(response.body))['message']);
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  manage_Album(namealbum, nameoldalbum, keyword, description, status) async {
    print("////////////////");
    print(namealbum);
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/Album/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'namealbum': namealbum,
        'nameoldalbum': nameoldalbum,
        'keyword': keyword,
        'description': description,
        'status': status
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Addimage_clound(nameimage, pathinmage, dataimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/Addcloud_storage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'nameimage': await nameimage,
        'image': await dataimage,
        'AddressImage': await pathinmage,
        'datephoto': await now.toString(),
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //   print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getverify_email(var tokenUser) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/send_verified_email/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': tokenUser}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getallimage_clound() async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/imagecloudstorage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': await user_file_.IDuser}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  AddPhoto(nameimage, pathinmage, dataimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/uploadImage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'nameimage': await nameimage,
        'image': await dataimage,
        'AddressImage': await pathinmage,
        'datephoto': await now.toString(),
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  updatekeyword_image(namealbum, nameimg, keyword) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/updatekeyword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'tokenID': await user_file_.IDuser,
        'namealbum': namealbum,
        'imageID': nameimg,
        'keyword': keyword
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  getPhotoFromAPI() async {
    user_file user_file_ = await new user_file();
    print("Getphoto");
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/DataAlbum/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': await user_file_.IDuser}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  saveImage(String url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(
          "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }

  getPhotoFromAPIlogin(var token) async {
    //user_file user_file_ = await new user_file();
    //await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/DataAlbum/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': token}),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      // print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Delete_image_incloud(var tokenimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/Deletephoto_cloud/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'idimage': await tokenimage,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Delete_image_incHome(var tokenimage, var nameAlbum) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://202.28.72.73:10101/Deletedataphoto/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'namealbum': nameAlbum,
        'idphoto': await tokenimage,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //  print("DDDDDDDDDDDDDDDDDDDDDDDDDWSSSSSSSSSSSSs");
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
*/