//
//  ViewerController.h
//  BlogAssistant
//
//  Created by 橋口 湖 on 09/12/24.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomTableView;
@interface ViewerController : NSWindowController {

	IBOutlet NSArrayController* arrayController;
	IBOutlet CustomTableView* tableView;
}

@end
