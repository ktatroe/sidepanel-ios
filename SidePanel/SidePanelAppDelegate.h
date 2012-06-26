//
//  AppDelegate.h
//  SidePanel
//
//  Created by Kevin Tatroe on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define appDelegate ((SidePanelAppDelegate*)[[UIApplication sharedApplication] delegate])


@class MenuViewController;

@interface SidePanelAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController* contentViewController;
@property (strong, nonatomic) MenuViewController* menuViewController;

- (void) showSideMenu;
- (void) hideSideMenu;

@end
