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
#import "Utility.h"

@implementation QueueManager

#pragma mark -
#pragma mark Initilizer and Deallocation
static QueueManager* _sharedManager = nil;

#pragma mark -
#pragma mark Initialization and deallocation
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

- (NSUInteger)loadFiles
{
	NSFileManager* fm = [NSFileManager defaultManager];
	NSString* path = [[PathManager sharedManager] queuePath];
	NSError* error = nil;
	NSUInteger count = 0;
	NSUInteger total = 0;

	NSArray* files = [fm contentsOfDirectoryAtPath:path
											 error:&error];
	if (error) {
		NSLog(@"ERROR(loadFiles): %@", error);
		return 0;
	}
	ModelManager* mm = [ModelManager sharedManager];
	for (NSString* filename in files) {
		if ([[filename pathExtension] isEqualToString:@"plist"]) {
			total++;

			NSString* filepath = [path stringByAppendingPathComponent:filename];
			ResourceTransfer* resTran =
				[ResourceTransfer resourceTransferWithContentsOfFile:filepath];
			if (resTran) {
				if ([mm insertResourceWithTransfer:resTran]) {
					error = nil;
					if ([fm removeItemAtPath:filepath error:&error]) {
						count++;
					} else {
						NSLog(@"ERROR(loadFiles): %@", error);
					}
				}
			}
		}
	}
	return count;
}

#pragma mark -
#pragma mark Handling FSEvent
void fsevents_callback(
   ConstFSEventStreamRef streamRef,
   void *userData,
   size_t numEvents,
   void *eventPaths,
   const FSEventStreamEventFlags eventFlags[],
   const FSEventStreamEventId eventIds[])
{
	QueueManager* qm = (QueueManager*)userData;
	[qm loadFiles];
}

- (void)startObservingQueue
{
	if (fseventStream) {
		FSEventStreamStop(fseventStream);
		FSEventStreamInvalidate(fseventStream);
	}
	
	NSString* path = [[PathManager sharedManager] queuePath];
	NSArray* pathsToWatch = [NSArray arrayWithObjects:path, nil];
	void *selfPointer = (void*)self;
	FSEventStreamContext context = {0, selfPointer, NULL, NULL, NULL};
    NSTimeInterval latency = 1.0; /* Latency in seconds */
	
    /* Create the stream, passing in a callback */
	fseventStream = FSEventStreamCreate(NULL,
		  &fsevents_callback,
		  &context,
		  (CFArrayRef)pathsToWatch,
		  kFSEventStreamEventIdSinceNow,
		  latency,
		  kFSEventStreamCreateFlagNone /* Flags explained in reference */
		  );

    /* Create the stream before calling this. */
	FSEventStreamScheduleWithRunLoop(fseventStream,
		 CFRunLoopGetCurrent(),
		 kCFRunLoopDefaultMode
		 );
	
	FSEventStreamStart(fseventStream);
	
}



@end
