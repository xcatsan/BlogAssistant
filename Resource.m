//
//  Homepage.m
//  CustomCell
//

#import "Resource.h"
#import "CoreDataManager.h"
#import "PathManager.h"

@implementation Resource

@dynamic title, imageFilename, url;

- (NSImage*)image
{
	NSImage* image = nil;
	if (imageFilename) {
		NSString* path = [[PathManager sharedManager] imagePath];
		image = [[[NSImage alloc] initWithContentsOfFile:
				  [path stringByAppendingPathComponent:imageFilename]] autorelease];
	}
	return image;
}

@end
