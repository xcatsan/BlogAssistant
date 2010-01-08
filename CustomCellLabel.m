//
//  CustomCellLabel.m
//  CustomCellWithCoredata
//
//  Created by Hiroshi Hashiguchi on 09/12/17.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellLabel.h"

// #TODO: font size / kind
// #TODO: link
@implementation CustomCellLabel

- (id)init
{
	self = [super init];
	
	if (self) {
		self.textAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
							   [NSColor whiteColor], NSForegroundColorAttributeName,
							   [NSFont systemFontOfSize:10.5], NSFontAttributeName,
							   nil];
	}
	return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)buttonState value:(id)value
{
	NSRect rect = self.frame;
	rect.origin.x += cellFrame.origin.x;
	rect.origin.y += cellFrame.origin.y;
//	[[value valueForKeyPath:self.keyPath] drawAtPoint:p withAttributes:self.textAttributes];
	NSString* label = [value valueForKeyPath:self.keyPath];
	[label drawInRect:rect withAttributes:self.textAttributes];
}

@end
