//
//  SlideoutStoryboardSegue.m
//  Elias
//
//  Created by Kevin Tatroe on 2/23/12.
//  Copyright (c) 2012 Kevin Tatroe. All rights reserved.
//

#import "SlideoutStoryboardSegue.h"

@implementation SlideoutStoryboardSegue

- (void) perform
{
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}

@end
