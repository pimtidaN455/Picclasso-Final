import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/IR_Search.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';

class search {
  data_image_answer_search(var answer_search_des) async {
    var listimageshow_search = {};
    var listimageshow_cloud_des = [];
    use_API api = new use_API();
    var listimageshow_device_des = [];
    DBHelper db = new DBHelper();
    for (int i = 0; i < answer_search_des.length; ++i) {
      var id_image = answer_search_des[i];
      var data_img = await db.getPhoto_from_id(id_image);
      print("////////////////data///////////////////");
      if (data_img[0]['statuscloud'] == "True_Don't have device") {
        var mapAlbum = {
          'img': await api.GetImgCloud(await data_img[0]["Cloud_Storage"]),
          'nameimg': id_image,
        };
        listimageshow_cloud_des.add(await mapAlbum);
      } else {
        var mapAlbum = {
          'img': data_img[0]["photopath"],
          'nameimg': id_image,
        };
        listimageshow_device_des.add(await mapAlbum);
      }
      print(data_img);
    }
    listimageshow_search["device"] = listimageshow_device_des;
    listimageshow_search["cloud"] = listimageshow_cloud_des;
    //   db.getPhoto_from_id();
    print("listimageshow_search_for_des");
    return listimageshow_search;
  }

  manage_word(var keyword, var description) {
    for (int i = 0; i < keyword.length; ++i) {
      description = description + " " + keyword[i];
    }
    return description;
  }

  use_search_keyword(var keyword) async {
    var img_all = {};
    var listanswer = [];
    img_all['status_all'] = false;
    DBHelper db = new DBHelper();
    var get_photo = await db.getPhoto();

    for (var key in keyword) {
      var mapkey = {};

      mapkey['keyword'] = key;
      var list_image = [];
      if (get_photo.length != 0) {
        for (int i = 0; i < get_photo.length; ++i) {
          print("/////////////////***************////////////////");
          print(get_photo[i]['photodescriptions']);
          var textphoto = get_photo[i]['photodescriptions'] +
              " " +
              get_photo[i]['photokeyword'];
          if (textphoto.indexOf(key) > -1) {
            list_image.add(get_photo[i]['id']);
            img_all['status_all'] = true;
          }
        }
      }
      mapkey['All_image'] = list_image;
      listanswer.add(mapkey);
    }
    img_all['Data_search'] = listanswer;
    return img_all;
  }

//รับ des
  use_search_IR(var query) async {
    use_API api = new use_API();
    var data_allpic = [];
    var answer_all = {};
    var detectword = await api.detect_word(query);
    DBHelper db = DBHelper();
    var get_photo = [];
    get_photo = await db.getPhoto();
    print("photo");
    print(get_photo);
    print(get_photo.length);
    if (get_photo.length != 0) {
      for (int i = 0; i < get_photo.length; ++i) {
        var photo = {};
        print("/***************/");
        print(get_photo[i]);
        print(get_photo[i]["photodescriptions"].length);
        print("/***************/");
        if (get_photo[i]["photodescriptions"].length != 0) {
          photo['name'] = get_photo[i]["id"];
          var sentences = [];
          var text_ = "";
          for (int j = 0; j < get_photo[i]["photodescriptions"].length; ++j) {
            if (get_photo[i]["photodescriptions"][j] == "/" && j != 0) {
              sentences.add(text_);
              text_ = "";
            } else {
              text_ += get_photo[i]["photodescriptions"][j];
            }
          }
          photo['sentences'] = sentences;
          print("g-hkouhssssssssss");

          data_allpic.add(photo);
        }
      }
    }
    print(data_allpic);

    Ir callIr = new Ir();
    if (data_allpic.length != 0) {
      var sumword = callIr.countword(data_allpic);
      print("/////////// 1////////////");
      var listword_tf = callIr.countworddoctf(
          data_allpic); //เทียบทุกคำว่าอยู่ในวิชาไหนบ้างอยู่กี่คำ
      print("/////////// 2////////////");
      var name = callIr.savename(data_allpic); //
      print("/////////// 3////////////");
      var tf_word = callIr.Cal_tf(listword_tf, sumword);
      print("///////////  4////////////");
      var countdfx = callIr.countdf(listword_tf, name);
      print("/////////// 5////////////");
      var savew = callIr.saveword(countdfx);
      print("/////////// 6////////////");
      var idf = callIr.invert_idf(countdfx, name, savew);
      print("/////////// 7////////////");
      var weigth_tf_idf_ = callIr.weigth_tf_idf(tf_word, idf, name, savew);
      print("/////////// 8////////////");
      var weigth_query = callIr.weigthquery(await detectword, name);
      print("/////////// 9////////////");
      var quaryx = callIr.matching(await detectword, weigth_tf_idf_);
      print("/////////// 10 ////////////");
      print(listword_tf);
      print("//////////// name ///////////");
      print(name);
      print("///////////// tf //////////");
      print(weigth_tf_idf_);
      print("///////////// countdf //////////");
      print(countdfx);

      if (quaryx.length != 0) {
        var sim = callIr.Similarity(quaryx, weigth_query);
        print("///////////// Similarity //////////");
        print(sim);

        print("///////////// ranking //////////");
        answer_all['data_img_search'] = callIr.answer_IR(sim);
        answer_all['message'] = true;
      } else {
        print("ไม่พบคำดังกล่าว");
        answer_all['message'] = false;
      }
    } else {
      print("ไม่พบคำดังกล่าว");
      answer_all['message'] = false;
    }
    return answer_all;
  }
}
