//
//  OTSearchInXIB.m
//  OTSearchInXIB
//
//  Created by akron on 7/18/14.
//    Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import "OTSearchInXIB.h"
#import "OTWindowController.h"

static OTSearchInXIB *sharedPlugin;

@interface OTSearchInXIB()

@property (nonatomic, strong) OTWindowController* windowController;
@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation OTSearchInXIB

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource acccess
        self.bundle = plugin;
        
        // Create menu items, initialize UI, etc.

        // Sample Menu Item:
        NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Find"];
        if (menuItem) {
            [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
            NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Search in xib" action:@selector(doMenuAction) keyEquivalent:@""];
            [actionMenuItem setTarget:self];
            [[menuItem submenu] addItem:actionMenuItem];
        }
    }
    return self;
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    
    if (self.windowController.window.isVisible) {
        [self.windowController.window close];
    } else {
        if (self.windowController == nil) {
            OTWindowController *windowController =  [[OTWindowController alloc]initWithWindowNibName:@"OTWindowController"];
            self.windowController = windowController;
        }
        //!!!: how about the path is nil?
        [self.windowController.window makeKeyAndOrderFront:nil];
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
