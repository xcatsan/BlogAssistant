//
//  QueueManager.h
//  BlogAssistant
//
//  Created by 湖 on 10/02/03.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface QueueManager : NSObject {

}
+ (QueueManager*)sharedManager;

- (void)loadFiles;

@end
