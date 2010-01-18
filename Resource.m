// 
//  Resource.m
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/18.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import "Resource.h"
#import "CoreDataManager.h"
#import "PathManager.h"

@implementation Resource 

@dynamic imageFilename;
@dynamic title;
@dynamic url;
@synthesize image;

- (NSImage*)image
{
	if (!image && self.imageFilename) {
		NSString* path = [[PathManager sharedManager] imagePath];
		image = [[[NSImage alloc] initWithContentsOfFile:
				  [path stringByAppendingPathComponent:self.imageFilename]] autorelease];
	}
	return image;
}

@end
