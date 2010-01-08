//
//  TestAppController.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/25.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "TestAppController.h"
#import "ModelController.h"
#import "ViewerController.h"

@implementation TestAppController

#pragma mark -
#pragma mark Initialization and Deallocation
-(id)init
{
	self = [super init];
	
	if (self) {
	}
	
	return self;
}

-(void)awakeFromNib
{
	[arrayController setManagedObjectContext:
		[[ModelController sharedController] managedObjectContext]];
	
	viewerController = [[ViewerController alloc] init];
	[viewerController window];
}

- (void) dealloc
{
	[viewerController release];
	[super dealloc];
}


#pragma mark -
#pragma mark Event handler

-(IBAction)save:(id)sender
{
	[[ModelController sharedController] save];
}

@end
