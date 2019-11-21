#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "PrinterExecutorByZebraBitmap.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.

    const NSString *CHANNEL = @"com.ebest.dsd.bluetooth/sendAddress";
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:CHANNEL
                                            binaryMessenger:controller];

    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      if ([@"sendAddress" isEqualToString:call.method]) {
          NSString *address = call.arguments[@"address"];
          NSLog(@"address = %@",address);
          
          NSString *document = NSHomeDirectory();
          NSString *filePath = [document stringByAppendingString:@"/Documents/doc/img/print.png"];
          NSLog(@"filePath = %@",filePath);
          
          PrinterExecutorByZebraBitmap *printExecutor = [[PrinterExecutorByZebraBitmap alloc] init];
          printExecutor.address = address;
          printExecutor.imgPath = filePath;
          
          [printExecutor printByAddress];
          
      } else {
        result(FlutterMethodNotImplemented);
      }
    }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
