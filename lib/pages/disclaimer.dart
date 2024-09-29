import 'package:flutter/material.dart';

import '../main.dart';
import 'about.dart';

class Disclaimer extends StatelessWidget {
  Disclaimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Disclaimer", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => About()),
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
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 15.0, right: 15.0, left: 15.0),
                    child: Text("Our App name stands for All University. It is just an app created by a student to help students to get student portal, todo app, teams and outlook at one place. This app has features like autofill, pin page, fill url, send feedback and much more. Thanks.", style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text("All the information on this AU app (All University App) is published in good faith and for general information purpose only. AU App does not make any warranties about the completeness, reliability and accuracy of this information. ", style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 20.0, right: 15.0, left: 15.0),
                    child: Text("Any action you take upon the information you find on this app, is strictly at your own risk. AU app will not be liable for any losses and/or damages in connection with the use of our app.", style: TextStyle(fontSize: 15, color: Colors.white)),
                  )
                ],

            ),
              ),),
          )

        ],
      ),
    );
  }
}
