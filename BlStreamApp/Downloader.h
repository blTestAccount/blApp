//
//  Downloader.h
//  BlStreamApp
//
//  Created by Admin on 05/06/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DownloaderDelegate <NSObject>
@required
-(void) downloadCompletedWithData:(NSData*)data;
@end

@interface Downloader : NSObject
- (id) initWithDelegate:(id) delegate;
- (void) downloadDataFrom:(NSString*)url;
- (void) downloadImageDataFrom:(NSString *)url dataHandler:(void (^)(NSData *data))dataHandler;
- (void) clean;
@end
