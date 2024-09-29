import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Privacy Policy", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.teal,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:Text("Is Au App Safe?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("This app is 100% secure. We do not collect any data through this app. We only receive feedbacks through this app. In this app we have used cloud messaging and firestore storage to provide you the important notification for notes and materials.", style: TextStyle(fontSize: 15, color: Colors.white))),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(" This app is secure as you are just using the website inside the app like website in browser. In ToDo App your data is stored locally on your device. This App does store passwords or login id in your phone only.", style: TextStyle(fontSize: 15, color: Colors.white))),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:Text("How This App Works?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child:Text("This app is created using Google Dart and Flutter. This is a web view app. Android WebView is a pre-installed system component from Google that allows Android apps to display web content. ", style: TextStyle(fontSize: 15, color: Colors.white))),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:Text("Consent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child:Text("By using this app, you hereby consent to our Privacy Policy and agree to its disclaimer.", style: TextStyle(fontSize: 15, color: Colors.white))),
                  ],
                ),
              ),
            ),
          )
           ], ),
    );
  }
}
