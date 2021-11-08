#import <Cordova/CDV.h>

@interface IOSAppTracking : CDVPlugin

- (void) requestPermission:(CDVInvokedUrlCommand*)command;
- (void) canRequestTracking:(CDVInvokedUrlCommand*)command;
- (void) trackingAvailable:(CDVInvokedUrlCommand*)command;

@end