// MiniAppEngines.m

@import Flutter;
@import UIKit;
#import "MiniAppEngines.h"

static FlutterEngine *_flutterEngine;

@implementation MiniAppEngines

RCT_EXPORT_MODULE()

+ (void)initWithFlutterEngine:(FlutterEngine * _Nonnull)flutterEngine {
    _flutterEngine = flutterEngine;
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

RCT_EXPORT_METHOD(initialize:(RCTResponseSenderBlock)callback)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            self->_flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter"];
            // Runs the default Dart entrypoint with a default Flutter route.
            [self->_flutterEngine run];
            // Used to connect plugins (only if you have plugins with iOS platform code).
            [GeneratedPluginRegistrant registerWithRegistry:self->_flutterEngine];
            
            callback(@[[NSString stringWithFormat: @"init ok"]]);
        } @catch (NSException *exception) {
            //Log error info...
            callback(@[[NSString stringWithFormat: @"init error: "]]);
        }
    });
}

RCT_EXPORT_METHOD(openApplet:(NSString *)stringArgument callback:(RCTResponseSenderBlock)callback)
{
 
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            FlutterViewController *flutterViewController;
            FlutterEngine *fe;
            if (self.flutterEngine == nil && self->_flutterEngine == nil) {
                // It is not recommended, but we can create a FlutterViewController with an implicit FlutterEngine
                // https://flutter.dev/docs/development/add-to-app/ios/add-flutter-screen?tab=engine-objective-c-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine
                self->_flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter"];
                // Runs the default Dart entrypoint with a default Flutter route.
                [self->_flutterEngine run];
                // Used to connect plugins (only if you have plugins with iOS platform code).
                [GeneratedPluginRegistrant registerWithRegistry:self->_flutterEngine];
                callback(@[[NSString stringWithFormat: @"withNewEngine stringArgument: %@", stringArgument]]);
            } else {
                fe = self.flutterEngine == nil ? _flutterEngine : self.flutterEngine;
                // init FlutterViewController with engine provided by host app
                flutterViewController = [[FlutterViewController alloc] initWithEngine:fe nibName:nil bundle:nil];
                callback(@[[NSString stringWithFormat: @"withCachedEngine stringArgument: %@", stringArgument]]);
            }
            // fix ui
            [flutterViewController setModalPresentationStyle:UIModalPresentationFullScreen];
    
            UIViewController *rootController = UIApplication.sharedApplication.delegate.window.rootViewController;
            [rootController presentViewController:flutterViewController animated:YES completion:nil];

            FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"__native2flutter__" binaryMessenger:fe.binaryMessenger];
            [methodChannel invokeMethod:@"open_url" arguments:stringArgument result:^(id  _Nullable result) {
                NSLog(@"ios: %@", result);
            }];
            
            
        } @catch (NSException *exception) {
            //Log error info...
            callback(@[[NSString stringWithFormat: @"error: "]]);
        }
    });
}

RCT_EXPORT_METHOD(closeApplet:(NSString *)stringArgument callback:(RCTResponseSenderBlock)callback)
{
 
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            FlutterViewController *flutterViewController;
            FlutterEngine *fe;
            if (self.flutterEngine == nil && self->_flutterEngine == nil) {
                // It is not recommended, but we can create a FlutterViewController with an implicit FlutterEngine
                // https://flutter.dev/docs/development/add-to-app/ios/add-flutter-screen?tab=engine-objective-c-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine
                self->_flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter"];
                // Runs the default Dart entrypoint with a default Flutter route.
                [self->_flutterEngine run];
                // Used to connect plugins (only if you have plugins with iOS platform code).
                [GeneratedPluginRegistrant registerWithRegistry:self->_flutterEngine];
                callback(@[[NSString stringWithFormat: @"withNewEngine stringArgument: %@", stringArgument]]);
            } else {
                fe = self.flutterEngine == nil ? _flutterEngine : self.flutterEngine;
                // init FlutterViewController with engine provided by host app
                flutterViewController = [[FlutterViewController alloc] initWithEngine:fe nibName:nil bundle:nil];
                callback(@[[NSString stringWithFormat: @"withCachedEngine stringArgument: %@", stringArgument]]);
            }

            FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"__native2flutter__" binaryMessenger:fe.binaryMessenger];
            [methodChannel invokeMethod:@"open_url" arguments:stringArgument result:^(id  _Nullable result) {
                NSLog(@"ios: %@", result);
            }];
            
        } @catch (NSException *exception) {
            //Log error info...
            callback(@[[NSString stringWithFormat: @"error: "]]);
        }
    });
}

RCT_EXPORT_METHOD(sendCustomEvent:(NSString *)stringArgument callback:(RCTResponseSenderBlock)callback)
{
 
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            FlutterViewController *flutterViewController;
            FlutterEngine *fe;
            if (self.flutterEngine == nil && self->_flutterEngine == nil) {
                // It is not recommended, but we can create a FlutterViewController with an implicit FlutterEngine
                // https://flutter.dev/docs/development/add-to-app/ios/add-flutter-screen?tab=engine-objective-c-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine
                self->_flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter"];
                // Runs the default Dart entrypoint with a default Flutter route.
                [self->_flutterEngine run];
                // Used to connect plugins (only if you have plugins with iOS platform code).
                [GeneratedPluginRegistrant registerWithRegistry:self->_flutterEngine];
                callback(@[[NSString stringWithFormat: @"withNewEngine stringArgument: %@", stringArgument]]);
            } else {
                fe = self.flutterEngine == nil ? _flutterEngine : self.flutterEngine;
                // init FlutterViewController with engine provided by host app
                flutterViewController = [[FlutterViewController alloc] initWithEngine:fe nibName:nil bundle:nil];
                callback(@[[NSString stringWithFormat: @"withCachedEngine stringArgument: %@", stringArgument]]);
            }

            FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"__native2flutter__" binaryMessenger:fe.binaryMessenger];
            [methodChannel invokeMethod:@"CUSTOM_EVENT" arguments:stringArgument result:^(id  _Nullable result) {
                NSLog(@"ios: %@", result);
            }];
            
        } @catch (NSException *exception) {
            //Log error info...
            callback(@[[NSString stringWithFormat: @"error: "]]);
        }
    });
}

@end
