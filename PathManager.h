//
//  PathManager.h
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/13.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PathManager : NSObject {

	NSString* dataPath;
}
@property (retain) NSString* dataPath;

+ (PathManager*)sharedManager;

@end
