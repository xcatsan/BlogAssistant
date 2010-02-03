//
//  ResourceTransfer.h
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/02/01.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ResourceTransfer : NSObject {

	NSDate * createdDate;
	NSString * imageFilename;
	NSString * title;
	NSString * url;
	NSString * uuid;
}
@property (retain) NSDate * createdDate;
@property (retain) NSString * imageFilename;
@property (retain) NSString * title;
@property (retain) NSString * url;
@property (retain) NSString * uuid;

- (BOOL)save;
- (id)initWithContentsOfFile:(NSString*)filename;
+ (ResourceTransfer*)resourceTransferWithContentsOfFile:(NSString*)filename;

@end
