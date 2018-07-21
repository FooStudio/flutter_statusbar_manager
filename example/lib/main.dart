import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  MyApp();

  factory MyApp.forDesignTime() {
    // TODO: add arguments
    return new MyApp();
  }

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _statusBarHeight = 0.0;
  bool _statusBarColorAnimated = false;
  Color _statusBarColor = Colors.black;
  double _statusBarOpacity = 1.0;
  bool _statusBarHidden = false;
  StatusBarAnimation _statusBarAnimation = StatusBarAnimation.NONE;
  StatusBarStyle _statusBarStyle = StatusBarStyle.DEFAULT;
  bool _statusBarTranslucent = false;
  bool _loadingIndicator = false;
  bool _fullscreenMode = false;

  bool _navBarColorAnimated = false;
  Color _navBarColor = Colors.black;
  NavigationBarStyle _navBarStyle = NavigationBarStyle.DEFAULT;

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

  Widget renderTitle(String text) {
    final textStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
    return Text(text, style: textStyle);
  }

  void colorBarChanged(Color val) {
    this.setState(() {
      _statusBarColor = val;
    });
    updateStatusBar();
  }

  void updateStatusBar() {
    FlutterStatusbarManager.setColor(
        _statusBarColor.withOpacity(_statusBarOpacity),
        animated: _statusBarColorAnimated);
  }

  void statusBarAnimationChanged(StatusBarAnimation val) {
    this.setState(() {
      _statusBarAnimation = val;
    });
  }

  void statusBarStyleChanged(StatusBarStyle val) {
    this.setState(() {
      _statusBarStyle = val;
    });
    FlutterStatusbarManager.setStyle(val);
  }

  void colorNavBarChanged(Color val) {
    this.setState(() {
      _navBarColor = val;
    });
    updateNavBar();
  }

  void updateNavBar() {
    FlutterStatusbarManager.setNavigationBarColor(_navBarColor,
        animated: _navBarColorAnimated);
  }

  void navigationBarStyleChanged(NavigationBarStyle val) {
    this.setState(() {
      _navBarStyle = val;
    });
    FlutterStatusbarManager.setNavigationBarStyle(val);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Statusbar Manager example'),
        ),
        body: new Container(
          child: new Scrollbar(
            child: new ListView(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              children: <Widget>[
                renderTitle("Status Bar Height: $_statusBarHeight"),
                Divider(height: 25.0),
                renderTitle("Status Bar Color:"),
                SwitchListTile(
                  value: _statusBarColorAnimated,
                  title: new Text("Animated:"),
                  onChanged: (bool value) {
                    this.setState(() {
                      _statusBarColorAnimated = value;
                    });
                  },
                ),
                Text("Color:"),
                RadioListTile(
                    value: Colors.black,
                    title: Text("Black"),
                    onChanged: colorBarChanged,
                    dense: true,
                    groupValue: _statusBarColor),
                RadioListTile(
                    value: Colors.orange,
                    title: Text("Orange"),
                    onChanged: colorBarChanged,
                    dense: true,
                    groupValue: _statusBarColor),
                RadioListTile(
                    value: Colors.greenAccent,
                    title: Text("Green"),
                    onChanged: colorBarChanged,
                    dense: true,
                    groupValue: _statusBarColor),
                RadioListTile(
                    value: Colors.white30,
                    title: Text("White"),
                    onChanged: colorBarChanged,
                    dense: true,
                    groupValue: _statusBarColor),
                Text("Opacity:"),
                Slider(
                  value: _statusBarOpacity,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double val) {
                    this.setState(() {
                      _statusBarOpacity = val;
                    });
                    updateStatusBar();
                  },
                ),
                Divider(height: 25.0),
                renderTitle("Status Bar Hidden:"),
                SwitchListTile(
                  title: new Text("Hidden:"),
                  value: _statusBarHidden,
                  onChanged: (bool val) {
                    this.setState(() {
                      _statusBarHidden = val;
                    });
                    FlutterStatusbarManager.setHidden(_statusBarHidden,
                        animation: _statusBarAnimation);
                  },
                ),
                Text("Animation:"),
                RadioListTile(
                    value: StatusBarAnimation.NONE,
                    title: Text("NONE"),
                    onChanged: statusBarAnimationChanged,
                    dense: true,
                    groupValue: _statusBarAnimation),
                RadioListTile(
                    value: StatusBarAnimation.FADE,
                    title: Text("FADE"),
                    onChanged: statusBarAnimationChanged,
                    dense: true,
                    groupValue: _statusBarAnimation),
                RadioListTile(
                    value: StatusBarAnimation.SLIDE,
                    title: Text("SLIDE"),
                    onChanged: statusBarAnimationChanged,
                    dense: true,
                    groupValue: _statusBarAnimation),
                Divider(height: 25.0),
                renderTitle("Status Bar Style:"),
                RadioListTile(
                    value: StatusBarStyle.DEFAULT,
                    title: Text("DEFAULT"),
                    onChanged: statusBarStyleChanged,
                    dense: true,
                    groupValue: _statusBarStyle),
                RadioListTile(
                    value: StatusBarStyle.LIGHT_CONTENT,
                    title: Text("LIGHT_CONTENT"),
                    onChanged: statusBarStyleChanged,
                    dense: true,
                    groupValue: _statusBarStyle),
                RadioListTile(
                    value: StatusBarStyle.DARK_CONTENT,
                    title: Text("DARK_CONTENT"),
                    onChanged: statusBarStyleChanged,
                    dense: true,
                    groupValue: _statusBarStyle),
                Divider(height: 25.0),
                renderTitle("Status Bar Translucent:"),
                SwitchListTile(
                  title: new Text("Translucent:"),
                  value: _statusBarTranslucent,
                  onChanged: (bool val) {
                    this.setState(() {
                      _statusBarTranslucent = val;
                    });
                    FlutterStatusbarManager
                        .setTranslucent(_statusBarTranslucent);
                  },
                ),
                Divider(height: 25.0),
                renderTitle("Status Bar Activity Indicator:"),
                SwitchListTile(
                  title: new Text("Indicator:"),
                  value: _loadingIndicator,
                  onChanged: (bool val) {
                    this.setState(() {
                      _loadingIndicator = val;
                    });
                    FlutterStatusbarManager
                        .setNetworkActivityIndicatorVisible(_loadingIndicator);
                  },
                ),
                Divider(height: 25.0),
                renderTitle("Navigation Bar Color:"),
                SwitchListTile(
                  value: _navBarColorAnimated,
                  title: new Text("Animated:"),
                  onChanged: (bool value) {
                    this.setState(() {
                      _navBarColorAnimated = value;
                    });
                  },
                ),
                Text("Color:"),
                RadioListTile(
                    value: Colors.black,
                    title: Text("Black"),
                    onChanged: colorNavBarChanged,
                    dense: true,
                    groupValue: _navBarColor),
                RadioListTile(
                    value: Colors.orange,
                    title: Text("Orange"),
                    onChanged: colorNavBarChanged,
                    dense: true,
                    groupValue: _navBarColor),
                RadioListTile(
                    value: Colors.greenAccent,
                    title: Text("Green"),
                    onChanged: colorNavBarChanged,
                    dense: true,
                    groupValue: _navBarColor),
                RadioListTile(
                    value: Colors.white12,
                    title: Text("white"),
                    onChanged: colorNavBarChanged,
                    dense: true,
                    groupValue: _navBarColor),
                Divider(height: 25.0),
                renderTitle("Navigation Bar Style:"),
                RadioListTile(
                    value: NavigationBarStyle.DEFAULT,
                    title: Text("DEFAULT"),
                    onChanged: navigationBarStyleChanged,
                    dense: true,
                    groupValue: _navBarStyle),
                RadioListTile(
                    value: NavigationBarStyle.LIGHT,
                    title: Text("LIGHT"),
                    onChanged: navigationBarStyleChanged,
                    dense: true,
                    groupValue: _navBarStyle),
                RadioListTile(
                    value: NavigationBarStyle.DARK,
                    title: Text("DARK"),
                    onChanged: navigationBarStyleChanged,
                    dense: true,
                    groupValue: _navBarStyle),
                Divider(height: 25.0),
                renderTitle("Fullscreen mode:"),
                SwitchListTile(
                  title: new Text("Fullscreen:"),
                  value: _fullscreenMode,
                  onChanged: (bool val) {
                    this.setState(() {
                      _fullscreenMode = val;
                    });
                    FlutterStatusbarManager.setFullscreen(_fullscreenMode);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
