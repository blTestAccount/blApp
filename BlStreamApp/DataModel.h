//
//  DataModel.h
//  BlStreamApp
//
//  Created by Admin on 05/06/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property (nonatomic, retain) NSMutableArray *apps;

- (BOOL) parseData:(NSData*)data;
- (void) clean;
@end
