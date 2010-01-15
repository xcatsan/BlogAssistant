//
//  Homepage.h
//  CustomCell
//

#import <Cocoa/Cocoa.h>


@interface Resource : NSManagedObject {

	NSString* title;
	NSString* imageFilename;
	NSString* url;
}
@property (retain, nonatomic) NSString* title;
@property (retain, nonatomic) NSString* imageFilename;
@property (retain, nonatomic) NSString* url;

-(NSImage*)image;

@end
