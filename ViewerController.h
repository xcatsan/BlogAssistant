//
//  ViewerController.h
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/24.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomTableView;
@interface ViewerController : NSWindowController {

	IBOutlet NSArrayController* arrayController;
	IBOutlet CustomTableView* tableView;
}

-(void)reload;
@end
