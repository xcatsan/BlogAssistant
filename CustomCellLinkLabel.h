//
//  CustomCellLinkLabel.h
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/01/03.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CustomCellControl.h"

@interface CustomCellLinkLabel : CustomCellControl {

	NSDictionary* hoveredTextAttributes;
	NSDictionary* clickedTextAttributes;
}
@property (retain) NSDictionary* hoveredTextAttributes;
@property (retain) NSDictionary* clickedTextAttributes;

@end
