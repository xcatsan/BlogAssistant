//
//  TestAppController.h
//  BlogAssistant
//
//  Created by 橋口 湖 on 09/12/25.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ViewerController;
@interface TestAppController : NSObject {

	IBOutlet NSArrayController* arrayController;
	ViewerController* viewerController;
}

-(IBAction)save:(id)sender;

@end
