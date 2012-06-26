//
//  MenuViewController.h
//  SidePanel
//
//  Created by Kevin Tatroe
//  Copyright (c) 2012 Kevin Tatroe. All rights reserved.
//
//	Based on code by Nick Harris, (c) 2012 Sepia Labs.
//

#import <UIKit/UIKit.h>


@interface MenuViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* contentTableView;

@property (strong, nonatomic) IBOutlet UIImageView* screenShotImageView;
@property (strong, nonatomic) UIImage* screenShotImage;

@property (strong, nonatomic) UITapGestureRecognizer* tapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;

- (IBAction) showPanelAViewController;
- (IBAction) showPanelBViewController;

- (void) slideThenHide;
- (void) adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;

@end
