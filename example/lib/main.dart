import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _statusBarHeight = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    double statusBarHeight;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      statusBarHeight = await FlutterStatusbarManager.getHeight;
    } on PlatformException {
      statusBarHeight = 0.0;
    }
    if (!mounted) return;

    setState(() {
      _statusBarHeight = statusBarHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Statusbar Manager example'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Text("StatusBar height: $_statusBarHeight"),
              RaisedButton(
                child: Text("Set color default"),
                onPressed: () {
                  FlutterStatusbarManager.setColor(Colors.black.withOpacity(0.2));
                },
              ),
              RaisedButton(
                child: Text("Set color green"),
                onPressed: () {
                  FlutterStatusbarManager.setColor(Colors.greenAccent);
                },
              ),
              RaisedButton(
                child: Text("Set color yellow opacity animated"),
                onPressed: () {
                  FlutterStatusbarManager.setColor(Colors.yellow.withOpacity(0.5), animated: true);
                },
              ),
              RaisedButton(
                child: Text("Set hidden true"),
                onPressed: () {
                  FlutterStatusbarManager.setHidden(true, animation: StatusBarAnimation.SLIDE);
                },
              ),
              RaisedButton(
                child: Text("Set hidden false"),
                onPressed: () {
                  FlutterStatusbarManager.setHidden(false, animation: StatusBarAnimation.SLIDE);
                },
              ),
              RaisedButton(
                child: Text("Set style light-content"),
                onPressed: () {
                  FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
                },
              ),
              RaisedButton(
                child: Text("Set style dark-content"),
                onPressed: () {
                  FlutterStatusbarManager.setStyle(StatusBarStyle.DARK_CONTENT);
                },
              ),
              RaisedButton(
                child: Text("Set translucent true"),
                onPressed: () {
                  FlutterStatusbarManager.setTranslucent(true);
                },
              ),
              RaisedButton(
                child: Text("Set translucent false"),
                onPressed: () {
                  FlutterStatusbarManager.setTranslucent(false);
                },
              ),
              RaisedButton(
                child: Text("Set loading indicator true"),
                onPressed: () {
                  FlutterStatusbarManager.setNetworkActivityIndicatorVisible(true);
                },
              ),
              RaisedButton(
                child: Text("Set loading indicator false"),
                onPressed: () {
                  FlutterStatusbarManager.setNetworkActivityIndicatorVisible(false);
                },
              ),
              RaisedButton(
                child: Text("Set NavigationBar orange"),
                onPressed: () {
                  FlutterStatusbarManager.setNavigationBarColor(Colors.orange);
                },
              ),
              RaisedButton(
                child: Text("Set NavigationBar green animated"),
                onPressed: () {
                  FlutterStatusbarManager.setNavigationBarColor(Colors.green, animated: true);
                },
              ),
              RaisedButton(
                child: Text("Set NavigationBar Style dark"),
                onPressed: () {
                  FlutterStatusbarManager.setNavigationBarStyle(NavigationBarStyle.DARK);
                },
              ),
              RaisedButton(
                child: Text("Set NavigationBar Style light"),
                onPressed: () {
                  FlutterStatusbarManager.setNavigationBarStyle(NavigationBarStyle.LIGHT);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
