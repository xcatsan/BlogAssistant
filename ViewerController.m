//
//  ViewerController.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/24.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import "ViewerController.h"
#import "CoreDataManager.h"

#import "CustomCell.h"
#import "CustomCellButton.h"
#import "CustomCellImage.h"
#import "CustomCellLabel.h"
#import "CustomCellLinkLabel.h"
#import "CustomTableView.h"

#import "Resource.h"

@implementation ViewerController

#pragma mark -
#pragma mark Initialization and Deallocation
-(id)init
{
	self = [super initWithWindowNibName:@"Viewer"];
	
	if (self) {
	}

	return self;
}

-(void)awakeFromNib
{
	// setup NSArrayController
	[arrayController setManagedObjectContext:
		[[CoreDataManager sharedManager]  managedObjectContext]];
	
	NSSortDescriptor* sort = [[[NSSortDescriptor alloc]
							 initWithKey:@"createdDate" ascending:NO] autorelease];
	[arrayController setSortDescriptors:[NSArray arrayWithObject:sort]];


	// setup UI
	CustomCell* cell = [[[CustomCell alloc] init] autorelease];
	cell.managedObjectContext = [[CoreDataManager sharedManager] managedObjectContext];
	
	CustomCellButton* cellButton;

	cellButton = [[[CustomCellButton alloc]
				   initWithFrame:NSMakeRect(100,60, 0, 0)] autorelease];
	cellButton.title = @"COPY";
	cellButton.target = self;
	cellButton.action = @selector(clickCopy:);
	[cell addControl:cellButton];

	/*
	NSRect buttonFrame = cellButton.frame;
	CGFloat offset = buttonFrame.origin.x + buttonFrame.size.width + 5.0;

	cellButton = [[[CustomCellButton alloc]
				   initWithFrame:NSMakeRect(offset, 60, 0, 0)] autorelease];
	cellButton.title = @"TITLE";
	cellButton.target = self;
	cellButton.action = @selector(click:);
	[cell addControl:cellButton];
	 */
	
	CustomCellImage* cellImage = [[[CustomCellImage alloc]
initWithFrame:NSMakeRect(10, 10, 80, 80)] autorelease];
	cellImage.keyPath = @"image";
	[cell addControl:cellImage];
	
	CustomCellLabel* cellLabel;

	cellLabel = [[[CustomCellLabel alloc]
								   initWithFrame:NSMakeRect(100, 15, 200, 15)] autorelease];
	cellLabel.keyPath = @"title";
	[cell addControl:cellLabel];

	CustomCellLinkLabel* cellLinkLabel;
	cellLinkLabel = [[[CustomCellLinkLabel alloc]
								   initWithFrame:NSMakeRect(100, 30, 200, 15)] autorelease];
	cellLinkLabel.keyPath = @"url";
	[cell addControl:cellLinkLabel];
	
	
	[tableView setDataCell:cell];
	[tableView setup];
}

- (void) dealloc
{
	[super dealloc];
}


#pragma mark -
#pragma mark Event handler
-(void)clickCopy:(id)sender
{
	Resource* resource = (Resource*)sender;

	NSString* str = [NSString stringWithFormat:
		@"<a href=\"%@\" target=\"_blank\">%@</a>",
		resource.url, resource.title];
	NSLog(@"copy: %@", str);
	
	NSPasteboard* pb = [NSPasteboard generalPasteboard];
	NSArray* types = [NSArray arrayWithObjects:NSStringPboardType, nil];
	[pb declareTypes:types owner:self];
	[pb setString:str forType:NSStringPboardType];
}

#pragma mark -
#pragma mark Pulbic method
-(void)reload
{
	[arrayController setManagedObjectContext:
	 [[CoreDataManager sharedManager]  managedObjectContext]];
}
@end
