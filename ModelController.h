//
//  ModelController.h
//  BlogAssistant
//
//  Created by 橋口 湖 on 09/12/24.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Resource;
@interface ModelController : NSObject {

	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}
+ (ModelController*)sharedController;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

-(void)save;
- (NSString*)pathToSaveImage;

@end
