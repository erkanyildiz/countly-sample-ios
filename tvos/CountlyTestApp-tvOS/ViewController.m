// ViewController.m
//
// This code is provided under the MIT License.
//
// Please visit www.count.ly for more information.

#import "ViewController.h"
#import "Countly.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -
- (IBAction)onClick_event:(id)sender
{
    NSLog(@"%s tag: %li",__FUNCTION__,(long)[sender tag]);
    
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
            [ViewController crashTest0];
        break;

        case 12:
            [ViewController crashTest1];
        break;

        case 13:
            [ViewController crashTest2];
        break;

        
        default:break;
    }
}


+ (void)crashTest0
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self performSelector:@selector(thisIsTheUnrecognizedSelectorCausingTheCrash)];
#pragma clang diagnostic pop
}


+ (void)crashTest1
{
#ifndef __clang_analyzer__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    NSArray* anArray = @[@"one",@"two",@"three"];
    NSString* myCrashingString = anArray[5];
#pragma clang diagnostic pop
#endif
}


+ (void)crashTest2
{
#ifndef __clang_analyzer__
    int *nullPointer = NULL;
    *nullPointer = 2017;
#endif
}

@end
