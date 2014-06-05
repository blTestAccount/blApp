//
//  App.h
//  BlStreamApp
//
//  Created by Admin on 05/06/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject
@property (nonatomic, retain) NSString *appName;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *appNumber;
- (void) clean;
- (void) clear;
@end
