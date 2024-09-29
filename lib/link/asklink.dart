import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'databaselink.dart';
import '../home.dart';
import '../studentportal.dart';
import 'package:auapp/navigation.dart';

class LinkAsk extends StatefulWidget {
  const LinkAsk({Key? key}) : super(key: key);
  @override
  State<LinkAsk> createState() => _LinkAskState();
}

class _LinkAskState extends State<LinkAsk> {
  final _myBox2 = Hive.box('mybox2');
  SaveDataBaseLink db2 = SaveDataBaseLink();

  final linkController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late FirebaseAnalytics analytics;
  late FirebaseAnalyticsObserver observer;



  @override
  void initState() {
    if (_myBox2.get("LINK") == null) {
    } else {
      db2.loadData();
    }
    super.initState();
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics);
  }
  final _controller = TextEditingController();

  void saveData() {
    final checkLink = _controller.text.toLowerCase();
    final link = _controller.text;
    List<String> filWords = [".edu", "portal", "login", "amizone.net", "student", "faculty", "KnowledgePro", ".ac", "icloud", "campus", "pro"];
    List<String> expWords = ["search", "find", "tags", "videos", "free"];
    expWords = expWords.map((word) => word.toLowerCase()).toList();
    filWords = filWords.map((word) => word.toLowerCase()).toList();
     // Convert explicit words to lowercase
    if (filWords.any((word) => checkLink.contains(word)) && !expWords.any((word) => checkLink.contains(word))) {
      db2.updateDataBase(link);
      analytics.logEvent(
        name: 'link_saved',
        parameters: {'link': link},
      );
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Portal()));
    } else {
      const snackBar = SnackBar(
        content: Text(
            'Sorry you could not save such links!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void clearD(){
    _controller.clear();
    if(db2.userLink.isEmpty){
      const snackBar = SnackBar(
        content: Text(
            'There is no link saved!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      const snackBar = SnackBar(
        content: Text(
            'Link Deleted Successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    db2.clearData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
              child: Center(child: Text('Add Link', style: TextStyle(color: Colors.white),)),
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
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.green),
                child: const Column(
                  children: [
                    Text("Enter your student portal link by going to google and copy and paste the url here. Make sure that your link is valid, or else default page will open.", style: TextStyle(color: Colors.white)),
                    Text(""),
                    Text("Make sure to paste only student login link, or any university/college portal link, In case if your university link is not working please send us the link through feedback:)", style: TextStyle(color: Colors.white)),
                  ],
                )
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Paste Portal link",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              // Text("Your Current Link: ${db2.userLink[0][0]}", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 11),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                      ),
                      onPressed: () {saveData();},
                      child: const Text('Save'),
                    ),
                    const SizedBox(width: 50),
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
      drawer: const Navigation(),
    );
  }
}
