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
#import "ResourceExchange.h"

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
#pragma mark Utility
#define THUMNAIL_SIZE	200
-(NSImage*)thumnailImageFromView:(NSView*)view
{
	NSBitmapImageRep* bitmap =
		[view bitmapImageRepForCachingDisplayInRect:[view bounds]];

	[view cacheDisplayInRect:[view bounds] toBitmapImageRep:bitmap];

	NSImage* viewImage = [[NSImage alloc] initWithData:[bitmap TIFFRepresentation]];

	NSRect clippedRect = NSZeroRect;
	clippedRect.size = [viewImage size];

	if (clippedRect.size.width > clippedRect.size.height) {
		clippedRect.size.width = clippedRect.size.height;
	} else {
		clippedRect.origin.y = clippedRect.size.height - clippedRect.size.width;
		clippedRect.size.height = clippedRect.size.width;
	}

	NSSize thumnailSize = NSMakeSize(THUMNAIL_SIZE, THUMNAIL_SIZE);
	NSRect thumnailRect = NSZeroRect;
	thumnailRect.size = thumnailSize;

	NSImage* thumnailImage = [[[NSImage alloc] initWithSize:thumnailSize] autorelease];
	
	[thumnailImage lockFocus];
	[NSGraphicsContext saveGraphicsState];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];

	[viewImage drawInRect:thumnailRect fromRect:clippedRect operation:NSCompositeSourceOver fraction:1.0];

	[NSGraphicsContext restoreGraphicsState];
	[thumnailImage unlockFocus];

	[viewImage release];

	return thumnailImage;
}


#pragma mark -
#pragma mark Event handlers
-(void)addPage:(id)sender
{
	WebView* web_view = [sender representedObject];
	WebFrameView* frame_view = [[web_view mainFrame] frameView];
	NSView* doc_view = [frame_view documentView];

	// setup output data
	ResourceExchange* resourceEx = [[[ResourceExchange alloc] init] release];
	resourceEx.title = [web_view mainFrameTitle];
	resourceEx.url = [web_view mainFrameURL];

	// save image file
	NSBitmapImageRep* bitmap = [[NSBitmapImageRep alloc]
								initWithData:[[resource image] TIFFRepresentation]];
	NSData* data = [bitmap representationUsingType:NSPNGFileType
										properties:[NSDictionary dictionary]];
	[data writeToFile:[path stringByAppendingPathComponent:resourceEx.imageFilename]
		   atomically:YES];
	[bitmap release];

	// save data
	[resourceEx save];
	
	/*
	Resource* resource = [[ModelManager sharedManager] createResource];
	resource.url = url;
	resource.title = title;
	resource.image = [self thumnailImageFromView:doc_view];
	[[ModelManager sharedManager] save];
	 */

//	[[NSWorkspace sharedWorkspace] openFile:@"A" withApplication:@"BlogAssistant"];

}

@end
