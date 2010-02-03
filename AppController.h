//
//  TestAppController.h
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/25.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ViewerController;
@interface AppController : NSObject {

	IBOutlet NSArrayController* arrayController;
	ViewerController* viewerController;
}

-(IBAction)save:(id)sender;
-(IBAction)reset:(id)sender;
-(IBAction)loadFiles:(id)sender;

@end
