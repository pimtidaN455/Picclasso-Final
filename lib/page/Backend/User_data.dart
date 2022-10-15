import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class convert_data {
  var Albums_Create;
  var Email;
  var Login;
  var Firstname;
  var Lastname;
  var IDuser;

  convert_data(data_json) {
    Email = data_json['Email'];
    Firstname = data_json['Firstname'];
    Lastname = data_json['Lastname'];
    IDuser = data_json['IDUser'];
    Albums_Create = data_json['Albums_Create'];
    Login = data_json['Login'];
  }
}

class user_file {
  var Albums_Create;
  var Email;
  var Login;
  var Firstname;
  var Lastname;
  var IDuser;

  var Id_device;

  // var filepath_W = File('./lib/page/Backend/datafile/client_data.json');

  user_file() {
    // print("LLLLLLLLLLLLLLLololo");

    // print("IIIIIIIIIIIIIIIII");
  }

  getdata_user_file() async {
    var data_json = await getApplicationSupportDirectory()
        .then((Directory directory) async {
      //  print("dododo");
      Directory dir = directory;
      //  print("LLLLLLL");
      print(dir);
      File filepath_W = new File(dir.path + "/client_data.json");
      bool fileExists = filepath_W.existsSync();
      //  print("LLLLLLL");
      if (fileExists) {
        //    print("ggg");
        // read file

        print(filepath_W);
        var base64String = filepath_W.readAsStringSync();
        print(base64String);
        //  print("JJJJJJ");
        //print(data_json['Login']);

        print("Hashhhhhhhhhhhhhhhhhhhhhhhh");
        /* String h = data_json.toString();
        print(h);
        var bytes = await utf8.encode(await h);
        print(bytes);
        final StringHex = hex.encode(bytes);
        print(StringHex);
        final base64String = base64.encode(utf8.encode(StringHex));
        print(base64String);*/
        print("--------------------------");
        var decodebase64 = base64.decode(base64String);
        print(decodebase64);
        var baseutf8 = utf8.decode(decodebase64);
        print(baseutf8);
        var decodehex = hex.decode(baseutf8);
        var hexutf8 = utf8.decode(decodehex);
        print(hexutf8.runtimeType);
        var jsonh = jsonEncode(hexutf8);
        var data_json = jsonDecode(jsonDecode(jsonh));
        print(data_json.runtimeType);

        print("Hashhhhhhhhhhhhhhhhhhhhhhhh");
        print("KKKKKKKKKKKKKKKKKKKKKKK");
        print("JJJJJJ");
        // print(data_json["Login"]);
        if (data_json['Login'] != false) {
          Email = data_json['Email'];
          Firstname = data_json['Firstname'];
          Lastname = data_json['Lastname'];
          IDuser = data_json['IDUser'];
          Albums_Create = data_json['Albums_Create'];
        }
        Login = data_json['Login'];

        Id_device = data_json['Use_Device'];

        print("YYYYYYYYYYYYYYYYYY");
        print(Email);
        print(Login);
        // print(IDuser);
        return data_json;
      } else {
        print("HHHH");
        //  print("ddddddddddddddddddddd");
        // write file
        var data_json = {'Login': false, 'Use_Device': await Id_device};
        var user = jsonEncode(data_json);
        String h = user.toString();
        print(h);
        var bytes = utf8.encode(h);
        print(bytes);
        final StringHex = hex.encode(bytes);
        print(StringHex);

        final base64String = base64.encode(utf8.encode(StringHex));
        print(base64String);
        //แปลงไฟล์
        filepath_W.writeAsString(base64String);
        Login = data_json['Login'];
      }
    });
    // print(await "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");

    //print(await "fdffdfdf");

    // print("--------------------getdata_user_file*------------------");

    // print(
    // "--------------------getdata_user_filenhbhhhhhhhhhhhhhhhhhhhh------------------");
    //print(data_json['Login']);

/*
    Email = data_json['Email'];
    Firstname = data_json['Firstname'];
    Lastname = data_json['Lastname'];
    IDuser = data_json['IDUser'];
    Albums_Create = data_json['Albums_Create'];
    Login = data_json['Login'];
    Password = data_json['Password'];4*/
    /*
    print(Email);
    print(Login);
    print(IDuser);
    return data_json;*/
    /*
    print("GGGGasdasdasddsadasd");
    var file =
        File('./ProjectPhotoL-main/lib/Backend/datafile/client_data.json');
    // var G = (await file.readAsString());

    var data_json = jsonDecode(file.readAsStringSync());
    print(data_json.runtimeType);
    print(data_json);
    print("HHH");

    Email = data_json['Email'];
    Firstname = data_json['Firstname'];
    Lastname = data_json['Lastname'];
    IDuser = data_json['IDuser'];
    Albums_Create = data_json['Albums_Create'];
    Login = data_json['Login'];

    // print(user.runtimeType);
    //Map<String, dynamic> userMap = jsonDecode(G);

    // print(userMap['name']);*/
    return data_json;
  }

  Future<void> usedata() async {
    //print("--------------------getdata_user_file25------------------");
    print(getApplicationDocumentsDirectory());
    // print("--------------------getdata_user_file2------------------");
    //  Email = "HHHH";
  }

  write_user_file(map_data) {
    var user = jsonEncode(map_data);

    getApplicationSupportDirectory().then((Directory directory) {
      Directory dir = directory;
      File filepath_W = new File(dir.path + "/client_data.json");
      String h = user.toString();
      print(h);
      var bytes = utf8.encode(h);
      print(bytes);
      final StringHex = hex.encode(bytes);
      print(StringHex);

      final base64String = base64.encode(utf8.encode(StringHex));
      print(base64String);
      //แปลงไฟล์
      filepath_W.writeAsString(base64String);
      //แปลงไฟล์กลับ
    });
/*
    var user = jsonEncode(map_data);
    var file = filepath_W.writeAsStringSync(user);
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(map_data);
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    File('./ProjectPhotoL-main/lib/Backend/datafile/client_data.json')
        .writeAsString(user);*/
    return "Write_Success";
  }
}
