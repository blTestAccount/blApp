//
//  App.m
//  BlStreamApp
//
//  Created by Admin on 05/06/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "App.h"

@implementation App
- (void)clean {
    [self.appName release];
    [self.url release];
    [self.image release];
    [self.appNumber release];
}

- (void) clear {
    self.appName = nil;
    self.url = nil;
    self.image = nil;
    self.appNumber = nil;
}
@end
