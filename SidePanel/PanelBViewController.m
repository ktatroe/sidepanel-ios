//
//  PanelBViewController.m
//  SidePanel
//
//  Created by Kevin Tatroe
//  Copyright (c) 2012 Kevin Tatroe. All rights reserved.
//

#import "PanelBViewController.h"

@interface PanelBViewController ()

@end

@implementation PanelBViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }

    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) slideMenuButtonTouched
{
	appDelegate.contentViewController = self;

    [appDelegate showSideMenu];
}

@end
