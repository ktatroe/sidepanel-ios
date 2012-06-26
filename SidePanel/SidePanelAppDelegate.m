//
//  AppDelegate.m
//  SidePanel
//
//  Created by Kevin Tatroe on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SidePanelAppDelegate.h"
#import "MenuViewController.h"


@implementation SidePanelAppDelegate

@synthesize window = _window;

@synthesize contentViewController;
@synthesize menuViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
	self.menuViewController = [storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];

    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) showSideMenu
{    
    // before swaping the views, we'll take a "screenshot" of the current view
    // by rendering its CALayer into the an ImageContext then saving that off to a UIImage
	UIView* targetView = self.contentViewController.navigationController.view;
    CGSize viewSize = targetView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(viewSize, NO, 0.0);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // Read the UIImage object
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // pass this image off to the MenuViewController then swap it in as the rootViewController
    self.menuViewController.screenShotImage = image;
    self.window.rootViewController = self.menuViewController;
}

-(void) hideSideMenu
{
    // all animation takes place elsewhere. When this gets called just swap the contentViewController in
    self.window.rootViewController = self.contentViewController;
}

@end
