//
//  CustomCellImage.m
//  CustomCellWithCoredata
//
//  Created by Hiroshi Hashiguchi on 09/12/17.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellImage.h" 

#define SHADOW_OFFSET	5.0

@implementation CustomCellImage

// #TODO: Shrink image
// #TODO: Generalization ( take out getting NSImage process)
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)buttonState value:(id)value
{
	NSImage* image = [value valueForKey:self.keyPath];
	
	// #TODO: for 10.6
//	[image setFlipped:YES];
	
	NSSize viewSize = [controlView frame].size;

	NSRect cellFrame2 = cellFrame;
	cellFrame2.origin.y = viewSize.height - (cellFrame.origin.y + cellFrame.size.height);

	NSRect imageFrame = self.frame;
	imageFrame.origin.x += cellFrame.origin.x;

	imageFrame.origin.y = cellFrame2.origin.y +
		(cellFrame.size.height - (imageFrame.origin.y + imageFrame.size.height));

	[NSGraphicsContext saveGraphicsState];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];

	NSAffineTransform* xform = [NSAffineTransform transform];
	[xform translateXBy:0.0 yBy:viewSize.height];
	[xform scaleXBy:1.0 yBy:-1.0];
	[xform concat];
	[image drawInRect:imageFrame
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:1.0];
	[NSGraphicsContext restoreGraphicsState];

	/*
	imageFrame.origin.x += cellFrame.origin.x + SHADOW_OFFSET;
	imageFrame.origin.y += cellFrame.origin.y + SHADOW_OFFSET;
	imageFrame.size.width -= SHADOW_OFFSET*2;
	imageFrame.size.height -= SHADOW_OFFSET*2;

	// #TODO: for 10.6
	[image setFlipped:YES];
	
	NSShadow* shadow = [[[NSShadow alloc] init] autorelease];
	[shadow setShadowBlurRadius:SHADOW_OFFSET];
	[shadow setShadowOffset:NSMakeSize(SHADOW_OFFSET/1.5, -SHADOW_OFFSET/1.5)];
	[shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.5]];
	
	NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:imageFrame
														 xRadius:5.0
														 yRadius:5.0];
	[NSGraphicsContext saveGraphicsState];
	[shadow set];
	[path fill];
	[NSGraphicsContext restoreGraphicsState];
	
	[NSGraphicsContext saveGraphicsState];
	[path setClip];
	[image drawInRect:imageFrame
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:1.0];
	[NSGraphicsContext restoreGraphicsState];
	 */
}
@end
