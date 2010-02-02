//
//  PathManager.m
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/13.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "PathManager.h"

#define BASE_FOLDERNAME @"BlogAssistant"
#define IMAGE_FOLDERNAME @"Images"
#define QUEUE_FOLDERNAME @"Queue"

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

		NSFileManager* fm = [NSFileManager defaultManager];

		NSString* dataPath = [_sharedManager dataPath];
		if (![fm fileExistsAtPath:dataPath]) {
			[fm createDirectoryAtPath:dataPath attributes:nil];
		}

		NSString* imagePath = [_sharedManager imagePath];
		if (![fm fileExistsAtPath:imagePath]) {
			[fm createDirectoryAtPath:imagePath attributes:nil];
		}
		NSString* queuePath = [_sharedManager queuePath];
		if (![fm fileExistsAtPath:queuePath]) {
			[fm createDirectoryAtPath:queuePath attributes:nil];
		}
	}
	return _sharedManager;
}

- (void) dealloc
{
	[dataPath release];
	[super dealloc];
}

#pragma mark -
#pragma mark Path/Filename Utility
- (NSString*)imagePath
{
	return [dataPath stringByAppendingPathComponent:IMAGE_FOLDERNAME];
}

- (NSString*)queuePath
{
	return [dataPath stringByAppendingPathComponent:QUEUE_FOLDERNAME];
}



@end
