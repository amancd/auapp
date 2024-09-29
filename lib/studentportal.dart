import 'dart:math';

import 'package:auapp/pass/databasefile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';

import 'bookmark/databasebk.dart';
import 'link/databaselink.dart';
import 'package:auapp/navigation.dart';

class Portal extends StatefulWidget {
  const Portal({Key? key}) : super(key: key);

  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  final _myBox1 = Hive.box('mybox1');
  final _myBox2 = Hive.box('mybox2');
  SaveDataBase db = SaveDataBase();
  SaveDataBaseLink db2 = SaveDataBaseLink();
  SaveBookmark db3 = SaveBookmark();
  bool isLoading = true;
  String errorMessage = '';

  final GlobalKey<ScaffoldState> webViewKey = GlobalKey<ScaffoldState>();
  InAppWebViewController? webViewController;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_myBox1.get("DATA") == null) {
    } else {
      db.loadData();
    }
    if (_myBox2.get("LINK") == null) {
    } else {
      db2.loadData();
    }
  }

  void _saveBookmark() {
    const link = "Hello";
    db3.updateDataBase(link);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Page Pinned!'),
      ),
    );
  }

  void clearD() {
    if (db3.userBk.isEmpty) {
      const snackBar = SnackBar(
        content: Text('No Pinned Page'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text('Pinned Page Deleted Successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    db3.clearData();
  }

  Future<bool> _onWillPop() async {
    if (await webViewController?.canGoBack() ?? false) {
      webViewController?.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                      icon: const Icon(Icons.refresh),
                      onPressed: () async {
                        if (webViewController != null) {
                          webViewController!.reload();
                        } else {}
                      },
                    )
                  ],
                ),
                const Expanded(
                  child: Center(
                      child: Text(
                    'Portal',
                    style: TextStyle(color: Colors.white),
                  )),
                )
              ],
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      _saveBookmark();
                    },
                    icon: Transform.rotate(
                      angle: 45 * (pi / 180),
                      child: const Icon(Icons.push_pin),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      clearD();
                    },
                  ),
                ],
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(
                    url: db2.userLink.isNotEmpty
                        ? WebUri(db2.userLink[0][0])
                        : WebUri(
                            "https://techtutrcom.blogspot.com/p/instruction.html"),
                  ),
                  initialSettings: InAppWebViewSettings(
                      disableDefaultErrorPage: true,
                      cacheEnabled: false,
                      clearCache: true,
                      javaScriptEnabled: true),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStop: (controller, url) async {
                    setState(() {
                      isLoading = false;
                    });

                    final String? username = db.userList.isNotEmpty
                        ? db.userList[0][0]?.toString()
                        : null;
                    final String? password = db.userList.isNotEmpty
                        ? db.userList[0][1]?.toString()
                        : null;

                    if (username != null && password != null) {
                      controller.evaluateJavascript(source: '''
// List of common attributes and keywords for username and password fields
const usernameKeywords = ['username', 'email', 'user', 'login', 'userid'];
const passwordKeywords = ['password', 'pass', 'pwd'];

// Function to check if an element's attribute contains any of the keywords
function hasKeyword(element, keywords) {
  const attributes = ['id', 'name', 'placeholder', 'type'];
  for (const attribute of attributes) {
    if (element.hasAttribute(attribute)) {
      const value = element.getAttribute(attribute)?.toLowerCase() || '';
      if (keywords.some(keyword => value.includes(keyword))) {
        return true;
      }
    }
  }
  return false;
}

// Attempt to find and autofill the username and password fields
function autofillForm(username, password) {
  let usernameField, passwordField;

  // Look for all input elements on the page
  const inputs = document.getElementsByTagName('input');

  for (const input of inputs) {
    if (!usernameField && hasKeyword(input, usernameKeywords)) {
      usernameField = input;
      input.value = username;
      input.classList.add('md-form-control', 'valid');
      input.setAttribute('aria-invalid', 'false');
    } else if (!passwordField && hasKeyword(input, passwordKeywords)) {
      passwordField = input;
      input.value = password;
      input.classList.add('md-form-control', 'valid');
      input.setAttribute('aria-invalid', 'false');
    }
  }

  // Attempt to focus on the fields if they are found
  if (usernameField) usernameField.focus();
  if (passwordField) passwordField.focus();

  // Activate associated labels, if any
  if (usernameField || passwordField) {
    const labels = document.getElementsByTagName('label');
    for (const label of labels) {
      const associatedInput = label.getAttribute('for');
      if (associatedInput === usernameField?.id || associatedInput === passwordField?.id) {
        label.classList.add('active');
      }
    }
  }
}

// Call the function to autofill the form
autofillForm("$username", "$password");

''');
                    }
                    else {
                      // Handle the case when username or password is null
                      // For example, show an error message or take appropriate action
                    }
                  },
                  onReceivedHttpError: (controller, request, errorResponse) {
                    // Handle HTTP errors only for the main frame (main document)
                    if (request.isForMainFrame ?? false) {
                      setState(() {
                        errorMessage =
                            'No Internet. Please check your network.\n'
                            '\nIt could be possible that site is down or unreachable.';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('No Internet. Please check your network.'),
                        ),
                      );
                    }
                  },
                  onReceivedError: (controller, request, error) async {
                    // Handle general errors only for the main frame (main document)
                    if (request.isForMainFrame ?? false) {
                      setState(() {
                        errorMessage =
                            'No Internet. Please check your network.\n'
                            '\nIt could be possible that site is down or unreachable.';
                      });
                      const snackBar = SnackBar(
                        content:
                            Text('No Internet. Please check your network.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
              if (errorMessage.isNotEmpty)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Portal()),
                              );
                            },
                            child: const Text('Reload'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          drawer: const Navigation(),
        ));
  }
}
