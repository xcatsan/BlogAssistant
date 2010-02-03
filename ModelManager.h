//
//  ResourceManager.h
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/13.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Resource;
@class ResourceTransfer;
@interface ModelManager : NSObject {

}
+ (ModelManager*)sharedManager;

-(void)save;
-(BOOL)insertResourceWithTransfer:(ResourceTransfer*)resTran;

@end
