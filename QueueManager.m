//
//  QueueManager.m
//  BlogAssistant
//
//  Created by 湖 on 10/02/03.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "QueueManager.h"
#import "PathManager.h"
#import "ModelManager.h"
#import "Resource.h"
#import "ResourceTransfer.h"

@implementation QueueManager

#pragma mark -
#pragma mark Initilizer and Deallocation
static QueueManager* _sharedManager = nil;

+ (QueueManager*)sharedManager
{
	if (!_sharedManager) {
		_sharedManager = [[QueueManager alloc] init];
	}
	return _sharedManager;
}

- (void) dealloc
{
	[super dealloc];
}


#pragma mark -
#pragma mark Public methods

- (void)loadFiles
{
	NSFileManager* fm = [NSFileManager defaultManager];
	NSString* path = [[PathManager sharedManager] queuePath];
	NSError* error = nil;

	NSArray* files = [fm contentsOfDirectoryAtPath:path
											 error:&error];
	if (error) {
		NSLog(@"ERROR(loadFiles): %@", error);
		return;
	}
	ModelManager* mm = [ModelManager sharedManager];
	for (NSString* filename in files) {
		if ([[filename pathExtension] isEqualToString:@"plist"]) {
			ResourceTransfer* resTran =
				[ResourceTransfer resourceTransferWithContentsOfFile:filename];
			if (resTran) {
				[mm insertResourceWithTransfer:resTran];
			}
		}
	}
}

@end
