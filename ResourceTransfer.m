//
//  ResourceTransfer.m
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/02/01.
//  Copyright 2010 xcatsan.com. All rights reserved.
//
#import "ResourceTransfer.h"
#import "PathManager.h"
#import "Utility.h"

@implementation ResourceTransfer

@synthesize createdDate;
@synthesize imageFilename;
@synthesize title;
@synthesize url;
@synthesize uuid;

#pragma mark -
#pragma mark Initialization and deallocation
- (id)init
{
	self = [super init];
	if (self) {
		self.uuid = [Utility stringWithUUID];
		self.imageFilename = [NSString stringWithFormat:@"%@.png", uuid];
		self.createdDate = [NSDate date];
	}
	return self;
}

- (id)initWithContentsOfFile:(NSString*)filename
{
	self = [super init];
	if (self) {
		NSDictionary* inputDict = [NSDictionary dictionaryWithContentsOfFile:filename];
		if (inputDict) {
			for (NSString* key in [inputDict allKeys]) {
				[self setValue:[inputDict valueForKey:key] forKey:key];
			}
		}
	}
	return self;
}

+ (ResourceTransfer*)resourceTransferWithContentsOfFile:(NSString*)filename
{
	return [[[ResourceTransfer alloc] initWithContentsOfFile:filename] autorelease];
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

- (BOOL)save
{
	NSMutableDictionary* outputDict = [NSMutableDictionary dictionary];
	NSArray* propertyNames = [Utility getPropertyNamesOf:self];
	for (NSString* propertyName in propertyNames) {
		[outputDict setObject:[self valueForKey:propertyName]
					   forKey:propertyName];
	}
	
	NSString* filename = [self.uuid stringByAppendingPathExtension:@"plist"];
	NSString* path = [[[PathManager sharedManager] queuePath] stringByAppendingPathComponent:filename];
	return [outputDict writeToFile:path atomically:YES];
}

@end
