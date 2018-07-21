# flutter_statusbar_manager

Flutter Statusbar Manager, lets you control the status bar color, style (theme), visibility, and translucent properties across iOS and Android. With some added bonus for Android to control the Navigation Bar.

This plugin is based on React Native's [StatusBar](https://facebook.github.io/react-native/docs/statusbar) component.

The Navigation Bar code was taken from the awesome [flutter-screen-theme-plugin](https://github.com/g123k/flutter-screen-theme-plugin).

<p align="center">
  <img src="https://raw.githubusercontent.com/FooStudio/flutter_statusbar_manager/master/example/assets/android_statusbar.gif" alt="Demo App Android Status Bar" style="margin:auto" width="300" height="533">
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/FooStudio/flutter_statusbar_manager/master/example/assets/android_statusbar_hide.gif" alt="Demo App Android Status Bar hide" style="margin:auto" width="300" height="533">
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/FooStudio/flutter_statusbar_manager/master/example/assets/android_navbar.gif" alt="Demo App Android Nav Bar" style="margin:auto" width="300" height="533">
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/FooStudio/flutter_statusbar_manager/master/example/assets/iphone_8.gif" alt="Demo App Iphone 8" style="margin:auto" width="300" height="533">
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/FooStudio/flutter_statusbar_manager/master/example/assets/iphone_x.gif" alt="Demo App Iphone X" style="margin:auto" width="300" height="650">
</p>


## Installation
```bash
flutter_statusbar_manager : ^lastest_version
```
to your pubspec.yaml ,and run

```bash
flutter packages get
```
in your project's root directory.

### Basic Usage

Create a new project with command

```
flutter create myapp
```

On iOS add the following in your Info.plist:
```xml
<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>
```

Import the plugin in lib/main.dart like this:
```dart
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
```

## Methods

#### setColor
###### Platforms: Android

The `setColor` method will set the status bar background color. On iOS the method will always return a successful `Future`.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| color |`Color`| none | Yes | The color to be set as background, can use colors with opacity. |
| animated |`bool`| false | No | Whether or not to animate the color change. |

```dart
await FlutterStatusbarManager.setColor(Colors.green, animated:true);
```

#### setTranslucent
###### Platforms: Android

The `setTranslucent` method will set the status bar translucent status. On iOS the methods will always return a successful `Future`.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| translucent |`bool`| none | Yes | Whether or not the status bar will be translucent. |

```dart
await FlutterStatusbarManager.setTranslucent(true);
```

#### setHidden
###### Platforms: Android, iOS

The `setHidden` will hide the status bar.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| hidden |`bool`| none | Yes | Whether or not to hide the status bar. |
| animation |`StatusBarAnimation`| StatusBarAnimation.NONE | No | The hiding animation to use `(iOS only)`. |

```dart
await FlutterStatusbarManager.setHidden(true, animation:StatusBarAnimation.SLIDE);
```

#### setStyle
###### Platforms: Android, iOS

The `setStyle` method will set the status bar theme.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| style |`StatusBarStyle`| none | Yes | The status bar theme to use for styling, can either be light, dark, default. |

```dart
await FlutterStatusbarManager.setStyle(StatusBarStyle.DARK_CONTENT);
```

#### setNetworkActivityIndicatorVisible
###### Platforms: iOS

The `setNetworkActivityIndicatorVisible` method will show or hide the activity indicator, On Android the method will always return a successful `Future`.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| visible |`bool`| none | Yes | Whether or not to show the activity indicator. |

```dart
await FlutterStatusbarManager.setNetworkActivityIndicatorVisible(true);
```


#### getHeight
###### Platforms: Android, iOS

The `getHeight` getter method will return the height of the status bar.

```dart
double height = await FlutterStatusbarManager.getHeight
```

## Bonus Methods

#### setNavigationBarColor
###### Platforms: Android

The `setNavigationBarColor` method will set the navigation bar background color. On iOS the method will always return a successful `Future`.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| color |`Color`| none | Yes | The color to be set as background. |
| animated |`bool`| false | No | Whether or not to animate the color change. |

```dart
await FlutterStatusbarManager.setNavigationBarColor(Colors.green, animated:true);
```

#### setNavigationBarStyle
###### Platforms: Android

The `setNavigationBarStyle` method will set the navigation bar theme.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| style |`NavigationBarStyle`| none | Yes | The navigation bar theme to use for styling, can either be light, dark, default. |

```dart
await FlutterStatusbarManager.setNavigationBarStyle(NavigationBarStyle.DARK);
```

#### setFullscreen
###### Platforms: Android, iOS

The `setFullscreen` method will set the app in fullscreen mode.

| Parameter|Type|Default| Required | Description |
| :------------|:---:|:---:|:---:|:-----|
| fullscreen |`bool`| none | Yes | Whether or not to set the app on fullscreen mode. |

```dart
await FlutterStatusbarManager.setNavigationBarStyle(NavigationBarStyle.DARK);
```

## Enums

#### StatusBarStyle
* StatusBarStyle.DEFAULT
* StatusBarStyle.LIGHT_CONTENT
* StatusBarStyle.DARK_CONTENT

#### StatusBarAnimation
* StatusBarAnimation.NONE
* StatusBarAnimation.FADE
* StatusBarAnimation.SLIDE

#### NavigationBarStyle
* NavigationBarStyle.DEFAULT
* NavigationBarStyle.DARK
* NavigationBarStyle.LIGHT

## Status bar
**Compatibility**: Android (6.0+) & iOS

On Android, it will only work with Android 6.0 (Marshmallow) and above devices.

## Navigation bar
**Compatibility**: Android only

Android 5.0 (Lollipop) and above: color

Android 8.0 (Oreo) and above: style (dark/light)