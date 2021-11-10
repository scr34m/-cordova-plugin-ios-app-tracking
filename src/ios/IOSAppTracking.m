#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <Cordova/CDVPluginResult.h>
#import "IOSAppTracking.h"

@implementation IOSAppTracking

- (void)requestPermission:(CDVInvokedUrlCommand*)command
{

    [self.commandDelegate runInBackground:^{
        __block NSMutableString* res = [[NSMutableString alloc] initWithString:@"none"];
        NSLog(@"[IOSAppTracking] requestPermission called!");

        if (@available(iOS 14, *)) {
            if ([ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
                NSLog(@"[IOSAppTracking] Asking permission...");
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                    switch (status) {
                        case ATTrackingManagerAuthorizationStatusAuthorized:
                            [res setString:@"authorized"];
                            break;

                        case ATTrackingManagerAuthorizationStatusNotDetermined:
                            [res setString:@"not-determined"];
                            break;

                        case ATTrackingManagerAuthorizationStatusRestricted:
                            [res setString:@"restricted"];
                            break;

                        case ATTrackingManagerAuthorizationStatusDenied:
                            [res setString:@"denied"];
                            break;

                        default:
                            [res setString:@"unknown"];
                            break;
                    }
                    NSLog(@"[IOSAppTracking] permission status result: %lu, %@", status, res);
                    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res];
                    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                }];
            } else {
                NSLog(@"[IOSAppTracking] Dialog was already shown, skipping ...");
                CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            }
        } else {
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}

- (void)canRequestTracking:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        bool res = false;
        NSLog(@"[IOSAppTracking] canRequestTracking called!");

        if (@available(iOS 14, *)) {
            res = [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined;
        }
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:res];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void)trackingAvailable:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        bool res = false;
        NSLog(@"[IOSAppTracking] trackingAvailable called!");

        if (@available(iOS 14, *)) {
            res = [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusAuthorized;
        }
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:res];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

@end