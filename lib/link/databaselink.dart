import 'package:hive_flutter/hive_flutter.dart';

class SaveDataBaseLink {
  List userLink = [];

  // reference our box
  final _myBox2 = Hive.box('mybox2');

  // run this method if this is the 1st time ever opening this app

  // load the data from database
  void loadData() {
    userLink = _myBox2.get("LINK");
  }

  void clearData() {
    userLink.clear();
    _myBox2.put("LINK", userLink);
  }

  // update the database
  void updateDataBase(String link){
      userLink.clear();
      userLink.add([link]);
      _myBox2.put("LINK", userLink);
  }
}