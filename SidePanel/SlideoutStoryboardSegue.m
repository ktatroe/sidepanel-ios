//
//  SlideoutStoryboardSegue.m
//  SidePanel
//
//  Created by Kevin Tatroe
//  Copyright (c) 2012 Kevin Tatroe. All rights reserved.
//

#import "SlideoutStoryboardSegue.h"


@implementation SlideoutStoryboardSegue

- (void) perform
{
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:YES];
}

@end
