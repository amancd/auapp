import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'databasefile.dart';
import '../home.dart';
import '../studentportal.dart';
import 'package:auapp/navigation.dart';

class FormSave extends StatefulWidget {
  const FormSave({Key? key}) : super(key: key);

  @override
  State<FormSave> createState() => _FormSaveState();
}

class _FormSaveState extends State<FormSave> {
  final _myBox1 = Hive.box('mybox1');
  SaveDataBase db = SaveDataBase();

  final nameController = TextEditingController();
  final passController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  void initState() {
      if (_myBox1.get("DATA") == null) {

      } else {
        db.loadData();
      }
    super.initState();
  }

  final _controller = TextEditingController();
  final _controller1 = TextEditingController();

  void showConsentDialog() {
    if(_controller.text == "" || _controller1.text == ""){
      const snackBar = SnackBar(
        content: Text(
            'Please fill the form first!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Consent'),
            content: const Text(
                'Do you consent to saving your username and password locally on your device?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  saveData();
                },
              ),
            ],
          );
        },
      );
    }
  }


  void saveData() {
    final username = _controller.text;
    final password = _controller1.text;
    if(username == "" || password == ""){
      const snackBar = SnackBar(
        content: Text(
            'Please fill the form first!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      db.userList.clear();
      db.updateDataBase(username, password);
      _controller.clear();
      _controller1.clear();
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Portal()));
    }

  }

  void clearD(){
    if(db.userList.isEmpty){
      const snackBar = SnackBar(
        content: Text(
            'There are no user details!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      const snackBar = SnackBar(
        content: Text(
            'User Details Deleted Successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    db.clearData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        backgroundColor: Colors.blueAccent,
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                ),
              ],
            ),
            const Expanded(
              child: Center(child: Text('Autofill', style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.school),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Portal()));
                },
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Home()));
                  }, icon: const Icon(Icons.home)),
            ],
          )
        ],
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            width: 325,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.85,
                    padding: const EdgeInsets.all(20),
                    color: Colors.teal,
                    child: const Column(
                      children: [
                        Text("This form is 100% secure. Note that we don't save your username and password, it will store in this app data locally. We have used local storage to do so.", style: TextStyle(color: Colors.white)),
                        Text(""),
                        Text("Note that this form will only work with some portals, if in case it is not working then, you can also use google password manager.", style: TextStyle(color: Colors.white)),
                      ],
                    )
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: "UserName",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller1,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 20.0, top: 20),
                  child: Row(
                    children: [
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purpleAccent,
                ),
                  onPressed: () {
                  showConsentDialog();
                  },
                  child: const Text('Save'),
                  ),

                    const SizedBox(width: 40),
                          ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          ),
                          onPressed: () {clearD();},
                          child: const Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const Navigation(),
    );
  }
}
