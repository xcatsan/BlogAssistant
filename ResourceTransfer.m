//
//  ResourceTransfer.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/02/01.
//  Copyright 2010 xcatsan.com. All rights reserved.
//
#import <objc/runtime.h>

#import "ResourceTransfer.h"
#import "PathManager.h"

@implementation ResourceTransfer

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
	self = [super init];
	if (self) {
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
	NSMutableDictionary* outputDict = [NSMutableDictionary dictionary];
	unsigned int outCount, i;
	objc_property_t *properties =
		class_copyPropertyList([self class], &outCount);
	
	for(i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		NSString *propertyName =
			[NSString stringWithUTF8String:property_getName(property)];
		[outputDict setObject:[self valueForKey:propertyName]
					   forKey:propertyName];
	}
	free(properties);

	NSString* filename = [self.uuid stringByAppendingPathExtension:@"plist"];
	NSString* path = [[[PathManager sharedManager] queuePath] stringByAppendingPathComponent:filename];
	return [outputDict writeToFile:path atomically:YES];
}


@end
