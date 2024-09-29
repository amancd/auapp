import 'package:hive_flutter/hive_flutter.dart';

class SaveDataBase{
  List userList = [];

  // reference our box
  final _myBox1 = Hive.box('mybox1');

  // run this method if this is the 1st time ever opening this app

  // load the data from database
  void loadData() {
    userList = _myBox1.get("DATA");
  }

  void clearData() {
    userList.clear();
    _myBox1.put("DATA", userList);
  }

  // update the database
  void updateDataBase(String username, String password) {
    userList.clear();
    userList.add([username, password]);
    _myBox1.put("DATA", userList);
  }
}