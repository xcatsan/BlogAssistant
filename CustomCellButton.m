//
//  CustomCellButton.m
//  CustomCellWithCoredata
//
//  Created by 橋口 湖 on 09/12/15.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellButton.h"

#define TITLE_MARGIN_X	10.0
#define TITLE_MARGIN_Y	4.0

@implementation CustomCellButton

#pragma mark -
#pragma mark Initialization and Deallocation

- (id)initWithFrame:(NSRect)rect
{
	self = [super initWithFrame:rect];
	
	if (self) {
		self.canHandleEvent = YES;
	}
	
	return self;
}

- (void) dealloc
{
	[title release];
	[super dealloc];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)state value:(id)value
{
	NSRect baseFrame = self.frame;
	baseFrame.origin.x += cellFrame.origin.x;
	baseFrame.origin.y += cellFrame.origin.y;
	
	NSRect backgroundFrame = NSInsetRect(baseFrame, 1.0, 1.0);

	NSBezierPath* basePath = [NSBezierPath
		bezierPathWithRoundedRect:backgroundFrame xRadius:11 yRadius:11];
	NSBezierPath* pathForShadow = [NSBezierPath
		bezierPathWithRoundedRect:backgroundFrame xRadius:11 yRadius:11];

	// [1] draw shadow
	[pathForShadow appendBezierPathWithRect:baseFrame];
	[pathForShadow setWindingRule:NSEvenOddWindingRule];	
	
	[NSGraphicsContext saveGraphicsState];
	NSShadow* shadow = [[NSShadow alloc] init];
	[shadow setShadowOffset:NSMakeSize(2, -2)];
	[shadow setShadowBlurRadius:1.0];
	[shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.5]];
	[shadow set];
	[[NSColor blackColor] set];
	[pathForShadow setClip];
	[basePath fill];
	[NSGraphicsContext restoreGraphicsState];
	
	// [2] draw background
	CGFloat cf1, cf2;
	switch (state) {
		case CONTROL_STATE_ON:
			cf1 = 1.00;
			cf2 = 0.75;
			break;
		case CONTROL_STATE_OVER:
			cf1 = 0.6;
			cf2 = 0.35;
			break;
		default:
			cf1 = 0.40;
			cf2 = 0.15;
			break;
	}
	CGFloat alpha = 0.5;
	NSColor* c1 = [NSColor colorWithCalibratedRed:cf1 green:cf1 blue:cf1 alpha:alpha];
	NSColor* c2 = [NSColor colorWithCalibratedRed:cf2 green:cf2 blue:cf2 alpha:alpha];
	NSArray* colors = [NSArray arrayWithObjects:c1, c2, nil];
	NSGradient *g = [[[NSGradient alloc] initWithColors:colors] autorelease];

	[g drawInBezierPath:basePath angle:90.0];

	// [3] draw frame
	[NSGraphicsContext saveGraphicsState];
	[basePath setClip];
	NSColor* frameColor = [NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:alpha];
	[frameColor set];
	[basePath setLineWidth:1.75];
	[basePath stroke];
	[NSGraphicsContext restoreGraphicsState];
	
	// [4] draw text
	NSRect textDrawingFrame = textFrame;
	textDrawingFrame.origin.x += cellFrame.origin.x;
	textDrawingFrame.origin.y += cellFrame.origin.y;
	[title drawInRect:textDrawingFrame withAttributes:textAttributes];

}


#pragma mark -
#pragma mark Original methods

- (void)setTitle:(NSString*)aTitle
{
	[aTitle retain];
	[title release];
	title = aTitle;

	NSSize textSize = [title sizeWithAttributes:textAttributes];
	NSSize frameSize = textSize;

	frameSize.width += TITLE_MARGIN_X*2;
	frameSize.height += TITLE_MARGIN_Y*2;
	frame.size = frameSize;
	
	textFrame = frame;
	textFrame.origin.x += (frameSize.width - textSize.width)/2.0;
	textFrame.origin.y += (frameSize.height - textSize.height)/2.0;		
}


@end
