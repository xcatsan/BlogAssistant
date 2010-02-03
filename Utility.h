//
//  Utility.h
//  BlogAssistant
//
//  Created by Hiroshi Hashiguchi on 10/01/08.
//  Copyright 2010 xcatsan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Utility : NSObject {

}

+ (NSString*)localizedStringForKey:(NSString*)key;
+ (NSArray*)getPropertyNamesOf:(id)object;

@end
