//
//  PluginController.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/01/06.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "PluginController.h"
#import "SXSafariContextMenuSwizzler.h"
#import "Utility.h"
#import <WebKit/WebKit.h>
#import "ResourceTransfer.h"
#import "ImageManager.h"

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
		

		item = [[[NSMenuItem alloc] initWithTitle:[Utility localizedStringForKey:@"MenuAddPage"]
										   action:@selector(addPage:)
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
	}
	
	return self;
}

- (void) dealloc
{
	[super dealloc];
}



#pragma mark -
#pragma mark Event handlers
-(void)addPage:(id)sender
{
	// determine view to save
	WebView* web_view = [sender representedObject];
	WebFrameView* frame_view = [[web_view mainFrame] frameView];
	NSView* doc_view = [frame_view documentView];

	// setup output data
	ResourceTransfer* resTran = [[[ResourceTransfer alloc] init] autorelease];
	resTran.title = [web_view mainFrameTitle];
	resTran.url = [web_view mainFrameURL];

	// save image file
	BOOL r1, r2;
	r1 = [[ImageManager sharedManager] writeView:doc_view
									withFilename:resTran.imageFilename];

	// save data
	if (r1) {
		r2 = [resTran save];
	} else {
		// error: saving the image
		NSLog(@"error: failed to save the image");
	}
	
	if (!r2) {
		// error: saving the plist
		NSLog(@"error: failed to save the plist");
	}


	
	/*
	if (r1 && r2) {
	 [[NSWorkspace sharedWorkspace] openFile:@"A" withApplication:@"BlogAssistant"];
	 }
	 */

}

@end
