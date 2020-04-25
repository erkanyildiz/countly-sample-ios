// ExtensionDelegate.m
//
// This code is provided under the MIT License.
//
// Please visit www.count.ly for more information.

#import "ExtensionDelegate.h"
#import "Countly.h"
#import "WatchConnectivity/WatchConnectivity.h"


@interface ExtensionDelegate () <WCSessionDelegate>
@end


@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching
{
    //NOTE: set your WCSession delegate before starting Countly, Countly will override and forward to it
    WCSession.defaultSession.delegate = self;

    CountlyConfig* config = CountlyConfig.new;
    config.appKey = @"YOUR_APP_KEY";
    config.host = @"https://YOUR_COUNTLY_SERVER";
    config.enableDebug = YES;

//  config.deviceID = @"customDeviceID"                               //Optional custom or system generated device ID
//  config.features = @[CLYCrashReporting];                                      //Optional features
    [Countly.sharedInstance startWithConfig:config];
}

- (void)applicationDidBecomeActive
{
    [Countly.sharedInstance resume];
}

- (void)applicationWillResignActive
{
    [Countly.sharedInstance suspend];
}


#pragma mark - WCSessionDelegate


- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo
{
    NSLog(@"didReceiveUserInfo (Original Delegate): %@", userInfo);
}

@end
