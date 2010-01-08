//
//  ModelController.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 09/12/24.
//  Copyright 2009 xcatsan.com. All rights reserved.
//
#define BASE_FOLDERNAME @"BlogAssistant"
#define DB_FILENAME @"BlogAssistant.db"
#define IMAGE_FOLDERNAME @"Images"

#import "ModelController.h"
#import "Resource.h"

@implementation ModelController

#pragma mark -
#pragma mark Utility (private)
- (NSString*)pathToSave
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
		NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString* path = [[paths objectAtIndex:0] stringByAppendingPathComponent:BASE_FOLDERNAME];
	return path;
}
- (NSString*)pathToSaveImage
{
	NSString* path = [self pathToSave];
	return [path stringByAppendingPathComponent:IMAGE_FOLDERNAME];
}

- (NSString*) stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [uuidString autorelease];
}

- (NSString*)createImageFilename
{
	NSString* filename =
	[NSString stringWithFormat:@"%@.png", [self stringWithUUID]];
	return filename;
}

#pragma mark -
#pragma mark Initilizer and Deallocation
static ModelController* _sharedController = nil;
+ (ModelController*)sharedController
{
	if (!_sharedController) {
		_sharedController = [[ModelController alloc] init];
	}
	return _sharedController;
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

    NSString *path = [self pathToSave];
	
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

#pragma mark -
#pragma mark Data management

-(void)save
{
	NSError* error = nil;


	[[self managedObjectContext] save:&error];

	if (error) {
		NSLog(@"%@", error);
	}
}

-(Resource*)createResource
{
	Resource* resource =
	(Resource*)[NSEntityDescription insertNewObjectForEntityForName:@"Resource"
											 inManagedObjectContext:[self managedObjectContext]];
				
	return resource;
}


@end
