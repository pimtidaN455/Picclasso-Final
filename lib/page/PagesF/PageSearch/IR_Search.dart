import 'dart:collection';
import 'dart:math';

class Ir {
  savename(var listdict) {
    var listname = [];
    for (var i in listdict) {
      listname.add(i["name"]);
    }
    return listname;
  }

  countworddoctf(var listdict) {
    var listj = [];
    var listn = [];

    for (var i in listdict) {
      for (var j in i["sentences"]) {
        if (listj.length == 0) {
          var word = {};
          word["word"] = j;
          listn.add(j);

          for (int k = 0; k < listdict.length; k++) {
            int c = 0;
            for (var l = 0; l < listdict[k]["sentences"].length; l++) {
              //print("ปริ้น");
              if (j == listdict[k]["sentences"][l]) {
                c = c + 1;
              }
            }
            word[listdict[k]["name"]] = c;
          }
          listj.add(word);
        } else {
          if (listn.indexOf(j) < 0) {
            var word = {};
            word["word"] = j;
            listn.add(j);
            for (int k = 0; k < listdict.length; k++) {
              var c = 0;
              for (int l = 0; l < listdict[k]["sentences"].length; l++) {
                if (j == listdict[k]["sentences"][l]) {
                  c = c + 1;
                }
              }
              word[listdict[k]["name"]] = c;
            }
            listj.add(word);
          }
        }
      }
    }
    return listj;
  }

  countword(var listdict) {
    var listsum = [];
    for (var i in listdict) {
      var dictcount = {};
      dictcount['name'] = i['name'];
      dictcount['sum_word'] = i['sentences'].length;
      listsum.add(dictcount);
    }
    return listsum;
  }

  Cal_tf(var listword_tf, var sumword) {
    var list_word_tf_all = [];

    for (var i in listword_tf) {
      var dataword = {};
      dataword['nameword'] = i['word'];

      var list_cal = [];
      for (var j in sumword) {
        var word_cal_tf = {};
        word_cal_tf['namedoc'] = j['name'];
        word_cal_tf['TF'] = i[j['name']] / j['sum_word'];
        list_cal.add(word_cal_tf);
      }
      dataword['data_cal_word'] = list_cal;
      list_word_tf_all.add(dataword);
    }
    return list_word_tf_all;
  }

  countdf(var listword_tf, var name) {
    var listdf = {};
    for (var i in listword_tf) {
      int c = 0;
      for (int j = 0; j < name.length; j++) {
        if (i[name[j]] > 0) {
          c = c + 1;
        }
      }
      listdf[i["word"]] = c;
    }
    return listdf;
  }

  invert_idf(var countdfx, var name, var savewordx) {
    var lengthname = name.length;
    var listidf = {};
    for (var i in savewordx) {
      listidf[i] = log((1 + lengthname) / (1 + countdfx[i])) + 1;
    }
    return listidf;
  }

  saveword(var countdfx) {
    var listword = [];
    for (var i in countdfx.keys) {
      listword.add(i);
    }
    return listword;
  }

  weigth_tf_idf(var tf_word, var idf, var name, save) {
    var list_weigth = [];
    for (var i in tf_word) {
      var dataword = {};
      dataword['nameword'] = i['nameword'];
      var list_word_w = [];
      for (var j in i['data_cal_word']) {
        var word_cal_w = {};
        word_cal_w['namedoc'] = j['namedoc'];
        word_cal_w['Weigth'] = idf[i['nameword']] * j['TF'];
        list_word_w.add(word_cal_w);
      }
      dataword['data_cal_word'] = list_word_w;
      list_weigth.add(dataword);
    }

    return list_weigth;
  }

  sumweigth(var weigth_tf_idf_, var name) {
    var listdict_sum_w = {};
    for (var i in name) {
      listdict_sum_w[i] = 0;
    }

    for (var i in weigth_tf_idf_) {
      for (var j in i['data_cal_word']) {
        var sum = listdict_sum_w[j['namedoc']] + j['Weigth'];
        listdict_sum_w[j['namedoc']] = sum;
      }
    }
    return listdict_sum_w;
  }

  matching(var quary, var weigth) {
    var listmaching = [];
    for (var i in quary) {
      for (var j in weigth) {
        if (j['nameword'] == i) {
          listmaching.add(j);
        }
      }
    }
    print("///////////////////*****mach******/////////////////////////////");
    print(listmaching);
    print("///////////////////*****mach******/////////////////////////////");
    return listmaching;
  }

  weigthquery(query, namedoc) {
    var length_doc = namedoc.length;
    var length_query = query.length;
    var dict_query = {};
    var list_check = [];
    for (var i in query) {
      if (list_check.contains(i) == false) {
        dict_query[i] = 1;
      } else {
        var sum = dict_query[i] + 1;
        dict_query[i] = sum;
      }
    }
    print("dict_query");
    print(dict_query);
    print("/////////////////////");
    var tf_query = {};
    for (var i in dict_query.keys) {
      var cal = dict_query[i] / length_query;
      tf_query[i] = cal;
    }
    print("tf_query");
    print(tf_query);
    print("/////////////////////");
    var idf_query = {};
    for (var i in query) {
      idf_query[i] = log((1 + length_doc) / (1 + dict_query[i])) + 1;
    }

    print("idf_query");
    print(idf_query);
    print("/////////////////////");
    var weigth_query = {};
    for (var i in query) {
      weigth_query[i] = idf_query[i] * tf_query[i];
    }
    print("weigth_query");
    print(weigth_query);
    print("/////////////////////");
    return weigth_query;
  }

  Similarity(var weigth_mach_doc, var weigth_query) {
    var sim = {};
    var length_query = weigth_query.length;
    if (weigth_mach_doc.length != 0 && weigth_mach_doc != null) {
      for (var i in weigth_mach_doc[0]['data_cal_word']) {
        sim[i['namedoc']] = 0;
      }
      for (var i in weigth_mach_doc) {
        for (var j in i['data_cal_word']) {
          var cal_sim;
          cal_sim = j['Weigth'] / weigth_query[i['nameword']];
          if (j['Weigth'] > weigth_query[i['nameword']]) {
            cal_sim = weigth_query[i['nameword']] / j['Weigth'];
          }
          var sumsim = sim[j['namedoc']] + cal_sim;
          sim[j['namedoc']] = sumsim;
        }
      }
      print(sim);
      for (var i in sim.keys) {
        var _sim_ = sim[i] / length_query;
        sim[i] = _sim_;
      }
    }
    return sim;
  }

  answer_IR(var similaryty) {
    var answer = [];
    var sortedKeys = SplayTreeMap.from(similaryty,
        (key1, key2) => similaryty[key1]!.compareTo(similaryty[key2]!));

    print("//////////////////sort/////////////////");
    print(sortedKeys);
    print("//////////////////sort/////////////////");
    int j = 0;
    for (var i in sortedKeys.keys) {
      j++;
      if (sortedKeys[i] != 0) {
        answer.add(i);
      }
    }
    return answer;
  }

  bestscore(var similaryty, var name) {
    var max_answer = {};
    max_answer["name"] = "";
    max_answer["score"] = -100;
    for (var i in name) {
      if (max_answer["score"] < similaryty[i]) {
        max_answer["score"] = similaryty[i];
        max_answer["name"] = i;
      }
    }
    return max_answer;
  }
}
