//
//  Utility.m
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/08.
//  Copyright 2010 xcatsan.com. All rights reserved.
//
#import <objc/runtime.h>
#import "Utility.h"


@implementation Utility

+ (NSString*)localizedStringForKey:(NSString*)key
{
	NSBundle* bundle = [NSBundle bundleForClass:[self class]];
	return [bundle localizedStringForKey:key value:@"" table:nil];
}

+ (NSArray*)getPropertyNamesOf:(id)object
{
	NSMutableArray* propertyNames = [NSMutableArray array];

	unsigned int outCount, i;
	objc_property_t *properties =
	class_copyPropertyList([object class], &outCount);
	
	for(i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		NSString *propertyName =
		[NSString stringWithUTF8String:property_getName(property)];
		[propertyNames addObject:propertyName];
	}
	free(properties);
	
	return propertyNames;
}

#pragma mark -
#pragma mark UUID @private
+ (NSString*)stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [uuidString autorelease];
}



@end
