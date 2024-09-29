import 'package:hive_flutter/hive_flutter.dart';

class SaveBookmark{
  List userBk = [];

  // reference our box
  final _myBox3 = Hive.box('mybox3');

  // run this method if this is the 1st time ever opening this app

  // load the data from database
  void loadData() {
    userBk = _myBox3.get("BK");
  }

  void clearData() {
    userBk.clear();
    _myBox3.put("BK", userBk);
  }

  // update the database
  void updateDataBase(String bookmark) {
      userBk.clear();
      userBk.add(bookmark);
      _myBox3.put("BK", userBk);
  }

}