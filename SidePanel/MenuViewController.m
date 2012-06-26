//
//  MenuViewController.m
//  SidePanel
//
//  Created by Kevin Tatroe
//  Copyright (c) 2012 Kevin Tatroe. All rights reserved.
//
//	Based on code by Nick Harris, (c) 2012 Sepia Labs.
//

#import <QuartzCore/QuartzCore.h>
#import "SidePanelAppDelegate.h"
#import "MenuViewController.h"
#import "PanelAViewController.h"
#import "PanelBViewController.h"


#define CONTENT_TYPE_ROW_HEIGHT (float) 44.0

#define CONTENT_TYPE_PANEL_A_INDEX 0
#define CONTENT_TYPE_PANEL_B_INDEX 1


@implementation MenuViewController

@synthesize contentTableView;

@synthesize screenShotImageView;
@synthesize screenShotImage;

@synthesize tapGesture;
@synthesize panGesture;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
	{
        // Custom initialization
    }

    return self;
}

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // create a UITapGestureRecognizer to detect when the screenshot recieves a single tap 
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapScreenShot:)];
    [screenShotImageView addGestureRecognizer:tapGesture];
    
    // create a UIPanGestureRecognizer to detect when the screenshot is touched and dragged
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [screenShotImageView addGestureRecognizer:panGesture];
	
	appDelegate.menuViewController = self;
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    // remove the gesture recognizers
    [self.screenShotImageView removeGestureRecognizer:self.tapGesture];
    [self.screenShotImageView removeGestureRecognizer:self.panGesture];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // when the menu view appears, it will create the illusion that the other view has slide to the side
    // what its actually doing is sliding the screenShotImage passed in off to the side
    // to start this, we always want the image to be the entire screen, so set it there
    [screenShotImageView setImage:self.screenShotImage];
    [screenShotImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    // now we'll animate it across to the right over 0.2 seconds with an Ease In and Out curve
    // this uses blocks to do the animation. Inside the block the frame of the UIImageView has its
    // x value changed to where it will end up with the animation is complete.
    // this animation doesn't require any action when completed so the block is left empty
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [screenShotImageView setFrame:CGRectMake(265, 0, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
	appDelegate.contentViewController = segue.destinationViewController;
}

- (void) slideThenHide
{
    // this animates the screenshot back to the left before telling the app delegate to swap out the MenuViewController
    // it tells the app delegate using the completion block of the animation
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [screenShotImageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:^(BOOL finished) {
		[appDelegate hideSideMenu];
	}];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) showPanelAViewController
{
    [self slideThenHide];

	[self performSegueWithIdentifier:@"toPanelA" sender:self];
}

- (IBAction) showPanelBViewController
{
    [self slideThenHide];

	[self performSegueWithIdentifier:@"toPanelB" sender:self];
}

- (void) singleTapScreenShot:(UITapGestureRecognizer*)gestureRecognizer 
{
    // on a single tap of the screenshot, assume the user is done viewing the menu
    // and call the slideThenHide function
    [self slideThenHide];
	
	if ([appDelegate.contentViewController isKindOfClass:[PanelAViewController class]]) {
		[self performSegueWithIdentifier:@"toPanelA" sender:self];
	}
	else {
		[self performSegueWithIdentifier:@"toPanelB" sender:self];
	}
}

- (void) panGestureMoveAround:(UIPanGestureRecognizer*)gesture;
{
    UIView* piece = [gesture view];

    [self adjustAnchorPointForGestureRecognizer:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y)];
        [gesture setTranslation:CGPointZero inView:[piece superview]];
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded) {
        [self slideThenHide];

		if ([appDelegate.contentViewController isKindOfClass:[PanelAViewController class]]) {
			[self performSegueWithIdentifier:@"toPanelA" sender:self];
		}
		else {
			[self performSegueWithIdentifier:@"toPanelB" sender:self];
		}
	}
} 

- (void) adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

#pragma mark - UITableViewDataSource

- (UIView*) tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
	return nil;
}

- (float) tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
	return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return CONTENT_TYPE_ROW_HEIGHT;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* sContentTypeCellIdentifier = @"ContentTypeTableCell";

	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:sContentTypeCellIdentifier];
	
	NSArray* titles = [NSArray arrayWithObjects:@"Panel A", @"Panel B", nil];
	cell.textLabel.text = NSLocalizedString([titles objectAtIndex:indexPath.row], nil);
	
	return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	[self.contentTableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == CONTENT_TYPE_PANEL_A_INDEX) {
		[self showPanelAViewController];
	}
	else if (indexPath.row == CONTENT_TYPE_PANEL_B_INDEX) {
		[self showPanelBViewController];
	}
}

@end
