//
//  OTWindowController.m
//  SearchInXIB
//
//  Created by akron on 7/19/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import "OTWindowController.h"
#import "XToDoModel.h"

@interface OTWindowController ()

@property (nonatomic) NSString *projectDir;

@end

@implementation OTWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    NSString* filePath = [[XToDoModel currentWorkspaceDocument].workspace.representingFilePath.fileURL path];
    self.projectDir = [filePath stringByDeletingLastPathComponent];
    NSLog(@"%@", self.projectDir);
}

- (IBAction)find:(id)sender{
    
    NSString *searchContent = [self.searchField stringValue];
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/bin/grep"];
    
    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: @"-i", @"-r", @"--include=*.xib", searchContent,self.projectDir,nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    [task launch];
    
    NSData *data;
    data = [[pipe fileHandleForReading] availableData];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data
                                   encoding: NSUTF8StringEncoding];
    
    self.resultTextView.string = string;
}

@end
