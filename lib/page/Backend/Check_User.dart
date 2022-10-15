import 'dart:ffi';
import 'dart:math';

import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';

class check_user {
  var id_device = "";

  use_API use_api = new use_API();

  signup(email, password, firstname, lastname) async {
    var signin = await use_api.Sign_up(email, password, firstname, lastname);

    return await signin;
  }

  login(email, password) async {
    user_file userdata_file = await new user_file();
    await userdata_file.getdata_user_file();
    var id_device = await userdata_file.Id_device;
    if (await id_device == null) {
      Random r = new Random();

      var iddevice = String.fromCharCode(r.nextInt(26) + 65) +
          String.fromCharCode(r.nextInt(26) + 65);

      for (int i = 0; i < 10; ++i) {
        var num = r.nextInt(10);

        iddevice += num.toStringAsFixed(0);
      }
      id_device = await iddevice;
    }
    print("--------------------------ID-----------------------");
    print(id_device);
    print("--------------------------ID-----------------------");

    //var id_device = "Phone1";
    var login = await use_api.Login(email, password, id_device);
    // print("DDDDDDDDDD");
    print(login);
    // print("DDDDDDDDDDD");

    var message = await login['message'];
    var datauser = await login['tokenU'];
    print("loginUUU");
    print(datauser);
    if (await message == 'Login success') {
      await userdata_file.write_user_file(datauser);

      //userdata_file.getdata_user_file();
    }
    //user_file userfile = new user_file();
    print(
        " -------------------------- Login success --------------------------");
    //print(userfile.Login);
    return await login;
  }

  logout() async {
    print("ssssss");
    user_file userdata_file = await new user_file();
    print(await userdata_file.IDuser);
    await userdata_file.getdata_user_file();
    await use_api.Logout(await userdata_file.IDuser);
    var data_json =
        await {'Login': false, 'Use_Device': await userdata_file.Id_device};

    //userdata_file.file.delete();

    await userdata_file.write_user_file(data_json);

    return "Logout success";
  }
}
