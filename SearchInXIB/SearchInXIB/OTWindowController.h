//
//  OTWindowController.h
//  SearchInXIB
//
//  Created by akron on 7/19/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OTWindowController : NSWindowController

@property (nonatomic, weak) IBOutlet NSSearchField *searchField;
@property (nonatomic, weak) IBOutlet NSButton *findButton;
@property (nonatomic) IBOutlet NSTextView *resultTextView;

- (IBAction)find:(id)sender;

@end
