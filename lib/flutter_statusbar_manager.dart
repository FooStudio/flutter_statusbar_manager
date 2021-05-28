import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StatusBarStyle { DEFAULT, LIGHT_CONTENT, DARK_CONTENT }

class _StatusBarStyle {
  static const String DEFAULT = "default";
  static const String LIGHT_CONTENT = "light-content";
  static const String DARK_CONTENT = "dark-content";

  static String getStyle(StatusBarStyle style) {
    switch (style) {
      case StatusBarStyle.DEFAULT:
        return DEFAULT;
      case StatusBarStyle.DARK_CONTENT:
        return DARK_CONTENT;
      case StatusBarStyle.LIGHT_CONTENT:
        return LIGHT_CONTENT;
      default:
        return DEFAULT;
    }
  }
}

enum StatusBarAnimation { NONE, FADE, SLIDE }

class _StatusBarAnimation {
  static const String NONE = "none";
  static const String FADE = "fade";
  static const String SLIDE = "slide";

  static String getAnimation(StatusBarAnimation animation) {
    switch (animation) {
      case StatusBarAnimation.NONE:
        return NONE;
      case StatusBarAnimation.FADE:
        return FADE;
      case StatusBarAnimation.SLIDE:
        return SLIDE;
      default:
        return NONE;
    }
  }
}

enum NavigationBarStyle { DARK, LIGHT, DEFAULT }

class _NavigationBarStyle {
  static const String DEFAULT = "default";
  static const String DARK = "light";
  static const String LIGHT = "dark";

  static String getStyle(NavigationBarStyle style) {
    switch (style) {
      case NavigationBarStyle.DEFAULT:
        return DEFAULT;
      case NavigationBarStyle.DARK:
        return DARK;
      case NavigationBarStyle.LIGHT:
        return LIGHT;
      default:
        return DEFAULT;
    }
  }
}

class FlutterStatusbarManager {
  static const MethodChannel _channel =
      const MethodChannel('flutter_statusbar_manager');

  static Future<bool?> setColor(Color color, {bool animated = false}) async {
    return await _channel
        .invokeMethod("setColor", {'color': color.value, 'animated': animated});
  }

  static Future<bool?> setTranslucent(bool translucent) async {
    return await _channel
        .invokeMethod("setTranslucent", {'translucent': translucent});
  }

  static Future<bool?> setHidden(bool hidden,
      {StatusBarAnimation animation = StatusBarAnimation.NONE}) async {
    return await _channel.invokeMethod("setHidden", {
      'hidden': hidden,
      'animation': _StatusBarAnimation.getAnimation(animation)
    });
  }

  static Future<bool?> setStyle(StatusBarStyle style) async {
    return await _channel
        .invokeMethod("setStyle", {'style': _StatusBarStyle.getStyle(style)});
  }

  static Future<bool?> setNetworkActivityIndicatorVisible(bool visible) async {
    return await _channel.invokeMethod(
        "setNetworkActivityIndicatorVisible", {'visible': visible});
  }

  static Future<bool?> setNavigationBarColor(Color color,
      {bool animated = false}) async {
    return await _channel.invokeMethod(
        "setNavigationBarColor", {'color': color.value, 'animated': animated});
  }

  static Future<bool?> setNavigationBarStyle(NavigationBarStyle style) async {
    return await _channel.invokeMethod("setNavigationBarStyle",
        {'style': _NavigationBarStyle.getStyle(style)});
  }

  static Future<double?> get getHeight async {
    return await _channel.invokeMethod("getHeight");
  }

  static setFullscreen(bool value) {
    if (value) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }
}
