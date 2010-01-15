//
//  PathManager.m
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/13.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "PathManager.h"

#define BASE_FOLDERNAME @"BlogAssistant"

@implementation PathManager

@synthesize dataPath;

#pragma mark -
#pragma mark Initilizer and Deallocation
static PathManager* _sharedManager = nil;
+ (PathManager*)sharedManager
{
	if (!_sharedManager) {
		_sharedManager = [[PathManager alloc] init];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(
			NSApplicationSupportDirectory, NSUserDomainMask, YES);
		_sharedManager.dataPath =
			[[paths objectAtIndex:0] stringByAppendingPathComponent:BASE_FOLDERNAME];
	}
	return _sharedManager;
}

- (void) dealloc
{
	[dataPath release];
	[super dealloc];
}

#pragma mark -
#pragma mark Path/Filename Utility (private)

#define IMAGE_FOLDERNAME @"Images"
- (NSString*)imagePath
{
	return [dataPath stringByAppendingPathComponent:IMAGE_FOLDERNAME];
}

- (NSString*) stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [uuidString autorelease];
}

- (NSString*)newImageFilename
{
	NSString* filename =
	[NSString stringWithFormat:@"%@.png", [self stringWithUUID]];
	return filename;
}


@end
