//
//  PluginController.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/01/06.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "PluginController.h"
#import "ModelController.h"
#import "SXSafariContextMenuSwizzler.h"
#import "ViewerController.h"
#import "Utility.h"
#import "Resource.h"
#import <WebKit/WebKit.h>

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
#pragma mark Utility
#define THUMNAIL_SIZE	100
-(NSImage*)thumnailImageFromView:(NSView*)view
{
	NSBitmapImageRep* bitmap =
		[view bitmapImageRepForCachingDisplayInRect:[view bounds]];
	[view cacheDisplayInRect:[view bounds] toBitmapImageRep:bitmap];
	NSImage* image = [[[NSImage alloc] initWithData:[bitmap TIFFRepresentation]] autorelease];
	
	NSSize thumnailSize = NSMakeSize(THUMNAIL_SIZE, THUMNAIL_SIZE);
	NSRect thumnailRect = NSZeroRect;
	thumnailRect.size = thumnailSize;
	NSImage* thumnailImage = [[[NSImage alloc] initWithSize:thumnailSize] autorelease];
	[thumnailImage lockFocus];
	[image drawInRect:thumnailRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	[thumnailImage unlockFocus];

	return thumnailImage;
}


#pragma mark -
#pragma mark Event handlers
-(void)addPage:(id)sender
{
	WebView* web_view = [sender representedObject];
	NSView* doc_view = [[[web_view mainFrame] frameView] documentView];

	NSString* title = [web_view mainFrameTitle];
	NSString* url = [web_view mainFrameURL];
	
	Resource* resource = [[ModelController sharedController] createResource];
	resource.url = url;
	resource.title = title;
	resource.image = [self thumnailImageFromView:doc_view];
	[[ModelController sharedController] save];

	[viewerController window];
}

@end
