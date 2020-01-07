#import "FlutterStatusbarManagerPlugin.h"

@implementation FlutterStatusbarManagerPlugin

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"flutter_statusbar_manager" binaryMessenger:[registrar messenger]];
    FlutterStatusbarManagerPlugin *instance = [[FlutterStatusbarManagerPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"setColor" isEqualToString:call.method]) {
        result(@YES);
    } else if ([@"setTranslucent" isEqualToString:call.method]) {
        result(@YES);
    } else if ([@"setHidden" isEqualToString:call.method]) {
        [self handleSetHidden:call result:result];
    } else if ([@"setStyle" isEqualToString:call.method]) {
        [self handleSetStyle:call result:result];
    } else if ([@"getHeight" isEqualToString:call.method]) {
        [self handleGetWidth:call result:result];
    } else if ([@"setNetworkActivityIndicatorVisible" isEqualToString:call.method]) {
        [self handleNetworkActivity:call result:result];
    } else if ([@"setNavigationBarColor" isEqualToString:call.method]) {
        result(@YES);
    } else if ([@"setNavigationBarStyle" isEqualToString:call.method]) {
        result(@YES);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)handleSetHidden:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *args = call.arguments;
    bool hidden = [args[@"hidden"] boolValue];
    NSString *animationString = (NSString *) args[@"animation"];
    UIStatusBarAnimation animation;
    if ([animationString isEqualToString:@"none"]) {
        animation = UIStatusBarAnimationNone;
    } else if ([animationString isEqualToString:@"fade"]) {
        animation = UIStatusBarAnimationFade;
    } else {
        animation = UIStatusBarAnimationSlide;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:animation];
    result(@YES);
}

- (void)handleSetStyle:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *args = call.arguments;
    NSString *statusBarStyleString = (NSString *) args[@"style"];
    bool animated = [args[@"animated"] boolValue];
    UIStatusBarStyle statusBarStyle;
    if ([statusBarStyleString isEqualToString:@"default"]) {
        statusBarStyle = UIStatusBarStyleDefault;
    } else if ([statusBarStyleString isEqualToString:@"light-content"]) {
        statusBarStyle = UIStatusBarStyleLightContent;
    } else if ([statusBarStyleString isEqualToString:@"dark-content"]) {
        if (@available(iOS 13.0, *)) {
            statusBarStyle = UIStatusBarStyleDarkContent;
        } else {
            statusBarStyle = UIStatusBarStyleDefault;
        }
    } else {
        statusBarStyle = UIStatusBarStyleDefault;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:animated];
    result(@YES);
}

- (void)handleGetWidth:(FlutterMethodCall *)call result:(FlutterResult)result {
    result(@(  [[UIApplication sharedApplication] statusBarFrame].size.height  ));
}

- (void)handleNetworkActivity:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSDictionary *args = call.arguments;
    bool visible = [args[@"visible"] boolValue];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    result(@YES);
}

@end
