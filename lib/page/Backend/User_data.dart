import 'dart:io';
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

  user_file() {}

  getdata_user_file() async {
    var data_json = await getApplicationSupportDirectory()
        .then((Directory directory) async {
      Directory dir = directory;
      print("dir");
      print(dir);
      File filepath_W = new File(dir.path + "/client_data.json");
      bool fileExists = filepath_W.existsSync();
      if (fileExists) {
        print("มี file อยู่แล้ว ใช้งานแอพอยู่แล้ว");
        print(filepath_W);

        var base64String = filepath_W.readAsStringSync();
        print("-------------แปลงไฟล์-------------");
        print(base64String);
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
        print("---------------------------------");
        if (data_json['Login'] != false) {
          Email = data_json['Email'];
          Firstname = data_json['Firstname'];
          Lastname = data_json['Lastname'];
          IDuser = data_json['IDUser'];
          Albums_Create = data_json['Albums_Create'];
        }
        Login = data_json['Login'];
        Id_device = data_json['Use_Device'];
        print("Account ที่ทำการ Login");
        print(Email);
        print(Login);
        return data_json;
      } else {
        print("ใช้งานแอพครั้งแรก ไม่มีไฟล์");
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
    return data_json;
  }

  Future<void> usedata() async {
    print(getApplicationDocumentsDirectory());
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
      filepath_W.writeAsString(base64String);
    });
    return "Write_Success";
  }
}
