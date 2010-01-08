//
//  CustomCellLinkLabel.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/01/03.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "CustomCellLinkLabel.h"


@implementation CustomCellLinkLabel

@synthesize hoveredTextAttributes, clickedTextAttributes;

- (id)initWithFrame:(NSRect)rect
{
	self = [super initWithFrame:rect];
	
	if (self) {
		self.canHandleEvent = YES;
		self.textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
									 [NSColor lightGrayColor], NSForegroundColorAttributeName,
									 [NSFont systemFontOfSize:10.5], NSFontAttributeName, nil];

		self.hoveredTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
									 [NSColor whiteColor], NSForegroundColorAttributeName,
									 [NSFont systemFontOfSize:10.5], NSFontAttributeName, nil];
		
		self.clickedTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
									 [NSColor whiteColor],
									  NSForegroundColorAttributeName,
									 [NSFont systemFontOfSize:10.5], NSFontAttributeName, nil];
	}
	return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)buttonState value:(id)value
{
	NSRect rect = self.frame;
	rect.origin.x += cellFrame.origin.x;
	rect.origin.y += cellFrame.origin.y;
	NSString* label = [value valueForKeyPath:self.keyPath];
	
	NSDictionary* attrs;
	switch (buttonState) {
		case CONTROL_STATE_ON:
			attrs = self.clickedTextAttributes;
			break;
		case CONTROL_STATE_OVER:
			attrs = self.hoveredTextAttributes;
			break;
		default:
			attrs = self.textAttributes;
			break;
	}
	
	[label drawInRect:rect withAttributes:attrs];
}

@end
