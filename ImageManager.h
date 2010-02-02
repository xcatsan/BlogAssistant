//
//  ImageManager.h
//  BlogAssistant
//
//  Created by 湖 on 10/02/02.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ImageManager : NSObject {

}
+ (ImageManager*)sharedManager;
-(NSImage*)thumnailImageFromView:(NSView*)view;
- (BOOL)writeView:(NSView*)view withFilename:(NSString*)filename;
- (NSImage*)readImageWithFilename:(NSString*)filename;

@end
