//
//  SXSafariContextMenuSwizzler.m
//  SafariPlugInStudy
//

#import "SXSafariContextMenuSwizzler.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>

static SXSafariContextMenuSwizzler* _shared_instance = nil;
static NSMutableArray* _menuItems;

@implementation SXSafariContextMenuSwizzler

#pragma mark -
#pragma mark Swizzling
-(void)swizzleMethodForClass:(Class)cls orginalSelector:(SEL)org_sel alternativeSelector:(SEL)alt_sel
{
    Method org_method = class_getInstanceMethod(cls, org_sel);
	class_addMethod(cls, alt_sel,
					class_getMethodImplementation([self class], alt_sel),
					method_getTypeEncoding(org_method));

    Method alt_method = class_getInstanceMethod(cls, alt_sel);
//	NSLog(@"org: %x", org_method);
//	NSLog(@"alt: %x", alt_method);
	method_exchangeImplementations(org_method, alt_method);

}

#pragma mark -
#pragma mark Initialization and Deallocation
//--

#pragma mark -
#pragma mark Class methods
+ (void)setup
{
	if (!_shared_instance) {
		_shared_instance = [[SXSafariContextMenuSwizzler alloc] init];
		
		[_shared_instance swizzleMethodForClass:objc_getClass("BrowserWebView")
								orginalSelector:@selector(
								  webView:contextMenuItemsForElement:defaultMenuItems:)
							alternativeSelector:@selector(
								  _sx_webView:contextMenuItemsForElement:defaultMenuItems:)];
		
		_menuItems = [[NSMutableArray alloc] init];
		// #???: When the objet will be released ? 
	}
}


/*
#pragma mark -
#pragma mark Event handler
- (void)takeScreenshot:(id)sender
{
	WebView* web_view = [sender representedObject];
	NSView* doc_view = [[[web_view mainFrame] frameView] documentView];

	NSBitmapImageRep* bitmap = [doc_view bitmapImageRepForCachingDisplayInRect:[doc_view bounds]];
	[doc_view cacheDisplayInRect:[doc_view bounds] toBitmapImageRep:bitmap];
	
	NSData* outdata = [bitmap representationUsingType:NSPNGFileType
										   properties:[NSDictionary dictionary]];
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
	NSString* path = [NSString stringWithFormat:@"%@/test.png", [paths objectAtIndex:0]];
	[outdata writeToFile:path atomically:YES];

	NSLog(@"took a screenshot");
}
*/

#pragma mark -
#pragma mark Swizzled methods for BrowserWebView
- (NSArray *)_sx_webView:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element
		defaultMenuItems:(NSArray *)defaultMenuItems {
	
//	NSLog(@"element: %@", element);
//	NSLog(@"defaultMenuItems: %@", defaultMenuItems);

	NSArray* menu_items = [self _sx_webView:sender
				 contextMenuItemsForElement:element
						   defaultMenuItems:defaultMenuItems];
	
	NSMutableArray* new_menu_items = [NSMutableArray arrayWithArray:menu_items];

	[new_menu_items addObject:[NSMenuItem separatorItem]];

	// "self" is BrowserWebView !!
	// Safari[2521] self: <BrowserWebView: 0x4c31c0> 
//	NSLog(@"self: %@", self);

	for (NSMenuItem* item in _menuItems) {
		[item setRepresentedObject:sender];
		[new_menu_items addObject:item];
	}

	return new_menu_items;
}

#pragma mark -
#pragma mark setting properties
+ (void)addMenuItem:(NSMenuItem*)menuItem
{
	[_menuItems addObject:menuItem];
}

@end
