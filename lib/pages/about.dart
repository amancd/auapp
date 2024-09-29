import 'package:auapp/pages/privacy.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class About extends StatelessWidget {
About({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text("About App", style: TextStyle(color: Colors.white),),
        backgroundColor:  Colors.blueAccent,
        centerTitle: true,
          actions: [
      IconButton(
      icon: const Icon(Icons.privacy_tip),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Privacy()),
        );
      },
    ),
  ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Container(
             color: Colors.blueAccent,
             child: const Padding(
               padding: EdgeInsets.all(15.0),
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Text("AU App stands for All University App. This is an app designed to help students to easily login student portal and get additional features like autofiill, pinned page, change link and much more..", style: TextStyle(fontSize: 15, color: Colors.white)),
                   ),
                   Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Text("In this app you can find notes, todo app and feedback which helps to share your problem directly with the app developer. This app helps you to access all your important links at one place. This will save your time and increases productivity.", style: TextStyle(fontSize: 15, color: Colors.white)),
                   ),
                   Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Text("This app give you option to quickly access important application like outlook and teams at one place. ", style: TextStyle(fontSize: 15, color: Colors.white)),
                   ),
                   Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Text("If you want your session to not expired or logout then please use the back and forward button given in the app.", style: TextStyle(fontSize: 15, color: Colors.white)),
                   ),
                   Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Text("AU App is powered by Google Dart SDK And Flutter.", style: TextStyle(fontSize: 15, color: Colors.white)),
                   )
                 ],
               ),
             ),
           ),
         )
        ],
      ),
    );
  }
}
