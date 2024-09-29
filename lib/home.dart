import 'package:auapp/navigation.dart';
import 'package:auapp/pages/disclaimer.dart';
import 'package:flutter/material.dart';
import 'package:auapp/link/asklink.dart';
import 'package:auapp/pages/about.dart';
import 'package:auapp/pages/privacy.dart';
import 'package:auapp/studentportal.dart';
import 'package:auapp/todo/mainpage.dart';
import 'package:auapp/pass/userform.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Define the list of colors
  final List<Color> colors = [
    Colors.blueAccent,
    Colors.cyan,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blueAccent,
    Colors.cyan,
    Colors.pink,
  ];

  // Define the list of dashboard items
  final List<_DashboardItem> dashboardItems = [
    _DashboardItem(title: "Home", icon: Icons.home, widget: null ),
    _DashboardItem(title: "Portal", icon: Icons.school, widget: const Portal()),
    _DashboardItem(title: "ToDo App", icon: Icons.check_circle, widget: const MainPage()),
    _DashboardItem(title: "Add Link", icon: Icons.link, widget: const LinkAsk()),
    _DashboardItem(title: "Autofill", icon: Icons.lock, widget: const FormSave()),
    _DashboardItem(title: "About", icon: Icons.person, widget: About()),
    _DashboardItem(title: "Privacy", icon: Icons.privacy_tip_outlined, widget: Privacy()),
    _DashboardItem(title: "Disclaimer", icon: Icons.error, widget: Disclaimer()),
  ];

  Card makeDashboardItem(_DashboardItem item, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          if (item.widget != null) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => item.widget!,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); // Slide in from the right
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
          } else {
            // Handle the null case, for example by showing a message or doing nothing
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No page linked')),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(1),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      drawer: const Navigation(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: dashboardItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (screenWidth * 0.30) / 100,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (context, index) {
                return makeDashboardItem(
                  dashboardItems[index],
                  colors[index % colors.length],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Helper class to define dashboard items
class _DashboardItem {
  final String title;
  final IconData icon;
  final Widget? widget; // Make widget nullable

  _DashboardItem({
    required this.title,
    required this.icon,
    this.widget,
  });
}

Future<void> _launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
  }
}
