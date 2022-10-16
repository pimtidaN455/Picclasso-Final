import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'dart:typed_data';
import 'dart:convert';

class Manage_Homepage {
  late File newFileNoCash;
  selectImages() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result == null) {
      return null;
    }
    for (int i = 0; i < result.files.length; i++) {
      newFileNoCash = await saveFilePermanently(result.files[i]);
      print('To path : ');
      print(newFileNoCash.path);
      print(result.files[i].name);

      File file = await File(newFileNoCash.path);
      Uint8List bytes = await file.readAsBytesSync();
      String base64Image = await base64Encode(bytes);
      print(await base64Image);
      use_API use_Api = await new use_API();
      //ส่งรูปไปที่ sever
      var addimg_cloud = await use_Api.AddPhoto(
        await result.files[i].name,
        await newFileNoCash.path,
        await base64Image,
      );
    }
    return true;
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    print('saveFilePermanently :');
    print(appStorage.path);
    print('saveFilePermanently Name :');
    print(file.name);
    return File(file.path!).copy(newFile.path);
  }
}
