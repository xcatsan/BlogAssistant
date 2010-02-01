//
//  ResourceExchange.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/02/01.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "ResourceExchange.h"


@implementation ResourceExchange

@synthesize createdDate;
@synthesize imageFilename;
@synthesize title;
@synthesize url;
@synthesize uuid;

#pragma mark -
#pragma mark UUID @private
- (NSString*) stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [uuidString autorelease];
}


#pragma mark -
#pragma mark Initialization and deallocation
- (id)init
{
	if (self = [super init]) {
		self.uuid = [self stringWithUUID];
		self.imageFilename = [NSString stringWithFormat:@"%@.png", uuid];
		self.createdDate = [NSDate date];
	}
	return self;
}

- (void) dealloc
{
	self.createdDate = nil;
	self.imageFilename = nil;
	self.title = nil;
	self.url = nil;
	self.uuid = nil;

	[super dealloc];
}


#pragma mark -
#pragma mark Public operation methods
-(BOOL)save
{
	
}


@end
