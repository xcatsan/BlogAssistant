//
//  PluginController.m
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/06.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "PluginController.h"
#import "SXSafariContextMenuSwizzler.h"
#import "ViewerController.h"

@implementation PluginController

static BOOL _initialized_flag = NO;
static PluginController* _shared_instance;

#pragma mark -
#pragma mark Class initialization
+ (void)initialize
{
	if (!_initialized_flag) {
		_initialized_flag = YES;

		// (1) PluginController
		// #???: The instance will live until Safari shut down
		_shared_instance = [[PluginController alloc] init];

		// (2) SXSafariContextMenuSwizzler
		[SXSafariContextMenuSwizzler setup];
		NSMenuItem* item;
		item = [[[NSMenuItem alloc] initWithTitle:@"test"
										   action:@selector(test:)
									keyEquivalent:@""] autorelease];
		
		[item setTarget:_shared_instance];
		[SXSafariContextMenuSwizzler addMenuItem:item];

		NSLog(@"BLogAssistant was loaded");
	}
}

#pragma mark -
#pragma mark Initialization and deallocation
- (id)init
{
	self = [super init];
	if (self) {
		viewerController = [[ViewerController alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	[viewerController release];
	[super dealloc];
}



#pragma mark -
#pragma mark Event handlers
-(void)test:(id)sender
{
	NSMenuItem* item = (NSMenuItem*)sender;
	NSLog(@"test: %@", [item representedObject]);
	[viewerController window];
}

@end
