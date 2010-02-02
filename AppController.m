//
//  TestAppController.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/25.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "AppController.h"
#import "CoreDataManager.h"
#import "ModelManager.h"
#import "ViewerController.h"

#import "ResourceTransfer.h"
@implementation AppController

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
		[[CoreDataManager sharedManager] managedObjectContext]];
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
	[[ModelManager sharedManager] save];
}

-(IBAction)reset:(id)sender
{
	NSLog(@"reset NSManagedObjectContext");
//	[[[CoreDataManager sharedManager] managedObjectContext] reset];
//	[arrayController rearrangeObjects];
	[arrayController setManagedObjectContext:
			[[CoreDataManager sharedManager] recreateContext]];
	[viewerController reload];
}

#pragma mark -
#pragma mark delegate
- (BOOL)application:(NSApplication *)theApplication
		   openFile:(NSString *)filename
{
	NSLog(@"opened");
	return YES;
}

#pragma mark -
#pragma mark test functions
-(IBAction)test1:(id)sender
{
	ResourceTransfer* ex = [[[ResourceTransfer alloc] init] autorelease];
	
}

@end
