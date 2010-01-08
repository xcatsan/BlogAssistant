//
//  CustomCellControl.m
//  CustomCellWithCoredata
//
//  Created by Hiroshi Hashiguchi on 09/12/16.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "CustomCellControl.h"


@implementation CustomCellControl

@synthesize frame, title, target, action, keyPath, textAttributes, canHandleEvent;

static NSDictionary* _defaultTextAttributes;

- (id)initWithFrame:(NSRect)rect
{
	self = [super init];
	if (self) {
		self.frame = rect;
		self.canHandleEvent = NO;
		
		if (!_defaultTextAttributes) {
			_defaultTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
										[NSColor whiteColor], NSForegroundColorAttributeName,
									  [NSFont systemFontOfSize:11], NSFontAttributeName, nil];
		}
		self.textAttributes = _defaultTextAttributes;
	}
	return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
				state:(NSInteger)state value:(id)value
{
	// should override this method in subclass
}

- (BOOL)hitTestAtPoint:(NSPoint)testPoint inFrame:(NSRect)cellFrame
{
	NSRect testRect = self.frame;
	testRect.origin.x += cellFrame.origin.x;
	testRect.origin.y += cellFrame.origin.y;
	return NSPointInRect(testPoint, testRect);
}


@end
