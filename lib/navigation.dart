import 'package:auapp/home.dart';
import 'package:auapp/studentportal.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'pages/about.dart';
import 'pages/disclaimer.dart';
import 'pages/privacy.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'todo/mainpage.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        width: 250,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ));
  }
}

Widget buildHeader(BuildContext context) {
  return Material(
    child: InkWell(
      child: Container(
        color: Colors.blueAccent,
        padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top,
          bottom: 24,),
        child: const Column(
          children: [
            Center(
              child: Text(
                "AU APP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildMenuItems(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(20),
    child: Wrap(
      runSpacing: 8,
      children: [
        ListTile(
          leading: const Icon(Icons.home, color: Colors.blueAccent),
          title: const Text("Home", style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const Home(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.school, color: Colors.blueAccent),
          title: const Text("Student Portal",
              style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const Portal(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.mail, color: Colors.blueAccent),
          title: const Text("Outlook", style: TextStyle(color: Colors.black)),
          onTap: () async {
            var teamsAppUrl = 'outlook:';
            try {
              await launchUrlString(teamsAppUrl); // Attempt to launch the Teams app
            } catch (e) {
              var openAppResult = await LaunchApp.openApp(
                androidPackageName: 'com.microsoft.office.outlook',
                iosUrlScheme: 'outlook:',
              );// Open the Play Store page for the Teams app
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.group, color: Colors.blueAccent),
          title: const Text("Teams", style: TextStyle(color: Colors.black)),
          onTap: () async {
            var teamsAppUrl = 'msteams:';
            try {
              await launchUrlString(teamsAppUrl); // Attempt to launch the Teams app
            } catch (e) {
              var openAppResult = await LaunchApp.openApp(
                androidPackageName: 'com.microsoft.teams',
                iosUrlScheme: 'msteams:',
              );// Open the Play Store page for the Teams app
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.check_circle, color: Colors.blueAccent),
          title: const Text("ToDo App", style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );

          },
        ),
        ListTile(
          leading: const Icon(Icons.book, color: Colors.blueAccent),
          title: const Text("Notes", style: TextStyle(color: Colors.black)),
          onTap: () {
            _launchUrl("https://play.google.com/store/apps/details?id=com.atomdyno.btech_cse_notes");
          },
        ),
        ListTile(
          leading: const Icon(Icons.share, color: Colors.blueAccent),
          title: const Text("Share", style: TextStyle(color: Colors.black)),
          onTap: () {
            shareAppLink();
          },
        ),
        const Divider(
          height: 5,
          thickness: 0.5,
          color: Colors.deepOrange,
        ),
        ListTile(
          leading: const Icon(Icons.description, color: Colors.deepOrange),
          title: const Text("About", style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => About(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );

          },
        ),
        ListTile(
          leading: const Icon(Icons.error, color: Colors.deepOrange),
          title:
          const Text("Disclaimer", style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => Disclaimer(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.policy, color: Colors.deepOrange),
          title: const Text("Privacy Policy",
              style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => Privacy(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        const ListTile(
          leading: Icon(Icons.copyright, color: Colors.deepOrange),
          title: Text("atomdyno.com", style: TextStyle(color: Colors.black)),
        ),
      ],
    ),
  );
}

void shareAppLink() {
  String message = 'Download AU App for ultimate convenience! Access your student/faculty portal, manage to-do notes effortlessly, and enjoy quick access to Teams and Outlook. Get comprehensive notes and study materials.\n\n';
  String playStoreLink = 'https://play.google.com/store/apps/details?id=com.apna.au.app';
  String shareText = message + playStoreLink;

  Share.share(shareText);
}

Future<void> _launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
  }
}