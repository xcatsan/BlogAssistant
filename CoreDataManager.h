//
//  ModelController.h
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/24.
//  Copyright 2009 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CoreDataManager : NSObject {

	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}
+ (CoreDataManager*)sharedManager;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (NSManagedObjectContext*)recreateContext;

@end
