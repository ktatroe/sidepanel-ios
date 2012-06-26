//
//  SidePanelAppDelegate.m
//  SidePanel
//
//  Created by Kevin Tatroe
//  Copyright (c) 2012 Kevin Tatroe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SidePanelAppDelegate.h"
#import "MenuViewController.h"


@implementation SidePanelAppDelegate

@synthesize window = _window;

@synthesize contentViewController;
@synthesize menuViewController;

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
	UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
	self.menuViewController = [storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];

    return YES;
}
							
- (void) applicationWillResignActive:(UIApplication*)application
{
}

- (void) applicationDidEnterBackground:(UIApplication*)application
{
}

- (void) applicationWillEnterForeground:(UIApplication*)application
{
}

- (void) applicationDidBecomeActive:(UIApplication*)application
{
}

- (void) applicationWillTerminate:(UIApplication*)application
{
}

- (void) showSideMenu
{    
	// generate an image from the current view
	UIView* targetView = self.contentViewController.navigationController.view;
    CGSize viewSize = targetView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(viewSize, NO, 0.0);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // pass this image off to the MenuViewController, then swap it in as the rootViewController
    self.menuViewController.screenShotImage = image;
    self.window.rootViewController = self.menuViewController;
}

- (void) hideSideMenu
{
	// the actual animation is done by the MenuViewController
    self.window.rootViewController = self.contentViewController;
}

@end
