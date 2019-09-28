import 'dart:convert';

import 'package:zx_waifu/iofile.dart';
import 'package:zx_waifu/main.dart';

class Settings {
  String lastId;
  List<String> liked, all;

  IOFile ioFile;

  Settings () {
    lastId = "";
    liked = List<String>();
    all = List<String>();
    ioFile = IOFile("settings.json");
    load();
  }

  void load () async {
    try {
      String json = await ioFile.read();
      var data = jsonDecode(json);
      lastId = data["lastId"];
      liked = data["liked"].cast<String>();
      all = data["all"].cast<String>();
    } catch (e) {
      lastId = rand.nextInt(200000).toString();
      all = List<String>.generate(200000, (int index) => index.toString());
      save();
    }
  }

  void save () async {
    var data = {
      "lastId": lastId,
      "liked": liked,
      "all": all
    };
    String json = jsonEncode(data);
    await ioFile.write(json);
  }

  void nextId() async {
    int nextId = rand.nextInt(all.length);
    lastId = all[nextId];
    all.removeAt(nextId);
    if (all.length == 0) {
      all = List<String>.generate(200000, (int index) => index.toString());
    }
    save();
  }
}