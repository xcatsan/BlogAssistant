//
//  ImageManager.m
//  BlogAssistant
//
//  Created by 湖 on 10/02/02.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "ImageManager.h"
#import "PathManager.h"

@implementation ImageManager

#pragma mark -
#pragma mark Initilizer and Deallocation
static ImageManager* _sharedManager = nil;

+ (ImageManager*)sharedManager
{
	if (!_sharedManager) {
		_sharedManager = [[ImageManager alloc] init];
	}
	return _sharedManager;
}

- (void) dealloc
{
	[super dealloc];
}


#pragma mark -
#pragma mark Public methods
- (BOOL)writeView:(NSView*)view withFilename:(NSString*)filename
{
	NSBitmapImageRep* bitmap = [[NSBitmapImageRep alloc]
								initWithData:[[self thumnailImageFromView:view] TIFFRepresentation]];
	NSData* data = [bitmap representationUsingType:NSPNGFileType
										properties:[NSDictionary dictionary]];
	NSString* path = [[PathManager sharedManager] imagePath];
	BOOL result = [data writeToFile:[path stringByAppendingPathComponent:filename]
		   atomically:YES];
	[bitmap release];

	return result;
}

- (NSImage*)readImageWithFilename:(NSString*)filename
{
	NSString* path = [[PathManager sharedManager] imagePath];
	NSImage* image = [[[NSImage alloc] initWithContentsOfFile:
			 [path stringByAppendingPathComponent:filename]] autorelease];
	return image;
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


@end
