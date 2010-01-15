//
//  ResourceManager.h
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/13.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Resource;
@interface ModelManager : NSObject {

}
+ (ModelManager*)sharedManager;

-(void)save;
-(Resource*)createResource;

@end
