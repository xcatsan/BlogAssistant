//
//  SXSafariContextMenuSwizzler.h
//  SafariPlugInStudy
//

#import <Cocoa/Cocoa.h>


@interface SXSafariContextMenuSwizzler : NSObject {
}

+ (void)setup;
+ (void)addMenuItem:(NSMenuItem*)menuItem;

@end
