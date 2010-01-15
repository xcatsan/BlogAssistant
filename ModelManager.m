//
//  ResourceManager.m
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/13.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "ModelManager.h"
#import "CoreDataManager.h"
#import "PathManager.h"
#import "Resource.h"

@implementation ModelManager

#pragma mark -
#pragma mark Initilizer and Deallocation
static ModelManager* _sharedManager = nil;

+ (ModelManager*)sharedManager
{
	if (!_sharedManager) {
		_sharedManager = [[ModelManager alloc] init];
	}
	return _sharedManager;
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark -
#pragma mark Data management

-(void)save
{
	NSError* error = nil;
	NSManagedObjectContext* moc = [[CoreDataManager sharedManager] managedObjectContext];

	// save image
	/*
	NSSet* insertedObjects = [moc insertedObjects];
	NSString* path = [[PathManager sharedManager] imagePath];
	 */

	/*
	for (id object in insertedObjects) {
		if ([object isKindOfClass:[Resource class]]) {
			Resource* resource = (Resource*)object;
			NSBitmapImageRep* bitmap = [[NSBitmapImageRep alloc]
										initWithData:[[resource image] TIFFRepresentation]];
			NSData* data = [bitmap representationUsingType:NSPNGFileType
												properties:[NSDictionary dictionary]];
			[data writeToFile:[path stringByAppendingPathComponent:resource.imageFilename]
				   atomically:YES];
			[bitmap release];	
			
		}
	}
	 */
	// save data
	[moc save:&error];
	
	if (error) {
		NSLog(@"%@", error);
		// #TODO: rollback ?
	}
}

#pragma mark -
#pragma mark Resource management

-(Resource*)createResource
{
	NSManagedObjectContext* moc = [[CoreDataManager sharedManager] managedObjectContext];

	Resource* resource =
	(Resource*)[NSEntityDescription insertNewObjectForEntityForName:@"Resource"
											 inManagedObjectContext:moc];
	
	resource.imageFilename = [[PathManager sharedManager] newImageFilename];
	return resource;
}

@end
