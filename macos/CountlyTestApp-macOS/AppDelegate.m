// AppDelegate.m
//
// This code is provided under the MIT License.
//
// Please visit www.count.ly for more information.

#import "AppDelegate.h"
#import "Countly.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    CountlyConfig* config = CountlyConfig.new;
    config.appKey = @"YOUR_APP_KEY";
    config.host = @"https://YOUR_COUNTLY_SERVER";
    config.enableDebug = YES;

//  config.features = @[CLYPushNotifications, CLYCrashReporting];  //Optional features
//  config.launchNotification = aNotification;              //Optional launch notification for push notification feature
//  config.deviceID = @"customDeviceID"                     //Optional custom or system generated device ID
    [Countly.sharedInstance startWithConfig:config];

    self.window.backgroundColor = [NSColor colorWithCalibratedRed:65/255.0 green:178/255.0 blue:70/255.0 alpha:1];
}


- (IBAction)onClick_events:(id)sender
{
    switch ([sender tag])
    {
        case 1:
            [Countly.sharedInstance recordEvent:@"button-click"];
        break;
        
        case 2:
            [Countly.sharedInstance recordEvent:@"button-click" count:5];
        break;
        
        case 3:
            [Countly.sharedInstance recordEvent:@"button-click" sum:1.99];
        break;
        
        case 4:
            [Countly.sharedInstance recordEvent:@"button-click" duration:3.14];
        break;
        
        case 5:
            [Countly.sharedInstance recordEvent:@"button-click" segmentation:@{@"k" : @"v"}];
        break;
        
        case 6:
            [Countly.sharedInstance recordEvent:@"button-click" segmentation:@{@"k" : @"v"} count:5];
        break;
        
        case 7:
            [Countly.sharedInstance recordEvent:@"button-click" segmentation:@{@"k" : @"v"} count:5 sum:1.99];
        break;
        
        case 8:
            [Countly.sharedInstance recordEvent:@"button-click" segmentation:@{@"k" : @"v"} count:5 sum:1.99 duration:0.314];
        break;
        
        case 9:
            [Countly.sharedInstance startEvent:@"timed-event"];
        break;
        
        case 10:
            [Countly.sharedInstance endEvent:@"timed-event" segmentation:@{@"k" : @"v"} count:1 sum:0];
        break;

        case 11:
        {
            NSArray* a = @[@1, @2, @3];
            NSLog(@"%@", a[4444]);
        }
        break;

        case 12:
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wundeclared-selector"
            [self performSelector:@selector(thisIsTheUnrecognizedSelectorCausingTheCrash)];
            #pragma clang diagnostic pop
        }
        break;

        case 13:
        {
            NSString* reason = @"This is the exception!";
            NSDictionary* userInfo = @{NSLocalizedDescriptionKey: @"And this is the exception's description."};
            NSException* e = [NSException exceptionWithName:NSGenericException reason:reason userInfo:userInfo];
            [e raise];
        }
        break;

        case 14:
        {
            #ifndef __clang_analyzer__
            int *nullPointer = NULL;
            *nullPointer = 2017;
            #endif
        }

        case 15:
        {
            NSLog(@"%@", (__bridge NSString *)(void *)100);
        }

        case 16:
        {
            [Countly.sharedInstance askForNotificationPermission];
        }

        default:break;
    }
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    [[NSAppleEventManager sharedAppleEventManager]
     setEventHandler:self
     andSelector:@selector(handleURLEvent:withReplyEvent:)
     forEventClass:kInternetEventClass
     andEventID:kAEGetURL];
}

- (void)handleURLEvent:(NSAppleEventDescriptor*)event
        withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
    NSString* url = [[event paramDescriptorForKeyword:keyDirectObject]
                     stringValue];
    NSLog(@"%@", url);
}

@end
