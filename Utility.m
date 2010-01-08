//
//  Utility.m
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/08.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "Utility.h"


@implementation Utility

+ (NSString*)localizedStringForKey:(NSString*)key
{
	NSBundle* bundle = [NSBundle bundleForClass:[self class]];
	return [bundle localizedStringForKey:key value:@"" table:nil];
}

@end
