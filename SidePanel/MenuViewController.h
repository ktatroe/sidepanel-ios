//
//  MenuViewController.h
//  SlideOutNavigationSample
//
//  Created by Nick Harris on 2/3/12.
//  Copyright (c) 2012 Sepia Labs. All rights reserved.
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
