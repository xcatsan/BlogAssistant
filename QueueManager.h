//
//  QueueManager.h
//  BlogAssistant
//
//  Created by 湖 on 10/02/03.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ResourceTransfer;

@interface QueueManager : NSObject {

	FSEventStreamRef fseventStream;
}
+ (QueueManager*)sharedManager;

- (NSUInteger)loadFiles;
- (void)startObservingQueue;
@end
