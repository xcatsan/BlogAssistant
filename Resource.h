//
//  Resource.h
//  BlogAssistant
//
//  Created by 橋口 湖 on 10/01/18.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Resource :  NSManagedObject  
{
	NSImage* image;
}

@property (retain) NSDate * createdDate;
@property (retain) NSString * imageFilename;
@property (retain) NSString * title;
@property (retain) NSString * url;
@property (retain) NSString * uuid;

@property (retain) NSImage * image;

@end


