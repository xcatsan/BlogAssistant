//
//  ModelController.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/24.
//  Copyright 2009 xcatsan.com. All rights reserved.
//
#import "CoreDataManager.h"
#import "PathManager.h"

#define DB_FILENAME @"BlogAssistant.db"


@implementation CoreDataManager


#pragma mark -
#pragma mark Initilizer and Deallocation
static CoreDataManager* _sharedManager = nil;
+ (CoreDataManager*)sharedManager
{
	if (!_sharedManager) {
		_sharedManager = [[CoreDataManager alloc] init];
	}
	return _sharedManager;
}

- (void) dealloc
{
	[managedObjectContext release];
	[persistentStoreCoordinator release];
	[managedObjectModel release];
	[super dealloc];
}


#pragma mark -
#pragma mark Accessors
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;

    NSString *path = [[PathManager sharedManager] dataPath];
	
    if ( ![fm fileExistsAtPath:path isDirectory:NULL] ) {
        [fm createDirectoryAtPath:path attributes:nil];
    }

	NSURL* url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:DB_FILENAME]];

    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
		initWithManagedObjectModel: [self managedObjectModel]];

    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
												  configuration:nil
															URL:url
														options:nil
														  error:&error]) {
		// [[NSApplication sharedApplication] presentError:error];
		NSLog(@"%@", error);
		return nil;
    }    
	
    return persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
	if (managedObjectModel != nil) {
        return managedObjectModel;
    }
	
	NSArray* bundles = [NSArray arrayWithObject:[NSBundle bundleForClass:[self class]]];
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:bundles] retain];    
    return managedObjectModel;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;	
}

@end
