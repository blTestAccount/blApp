//
//  DataModel.m
//  BlStreamApp
//
//  Created by Admin on 05/06/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "DataModel.h"
#import "App.h"

@implementation DataModel
- (id)init {
    if(self = [super init]) {
        _apps = [[NSMutableArray alloc] init] ;
    }
    return self;
}

- (BOOL)parseData:(NSData*) data {
    NSError *jsonError;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];

    NSDictionary *entry = dictionary[@"feed"][@"entry"];
    NSInteger index = 1;
    for (NSDictionary *element in entry) {
        App *app = [[App alloc] init];
        app.appName = element[@"im:name"][@"label"];
        app.url = element[@"im:image"][0][@"label"];
        app.appNumber = [[@(index++) stringValue] stringByAppendingString:@"."];
        [_apps addObject:app];
        [app release];
    }
    return YES;
}

- (void)clean {
    for (App *app in self.apps) {
        [app clean];
    }
    [self.apps release];
}
@end
