//
//  Downloader.m
//  BlStreamApp
//
//  Created by Admin on 05/06/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Downloader.h"

@interface Downloader() {
    NSURLSession *_session;
    id <DownloaderDelegate> _delegate;
}
@end

@implementation Downloader
- (id) initWithDelegate:(id) delegate {
    if(self = [super init]) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfig];
        _delegate = delegate;
    }
    return self;
}

- (void)downloadDataFrom:(NSString *)url {
    [self downloadFrom:url dataHandler:nil];
}

- (void)downloadImageDataFrom:(NSString *)url dataHandler:(void (^)(NSData *))dataHandler {
    [self downloadFrom:url dataHandler:dataHandler];
}

- (void) downloadFrom:(NSString*)url dataHandler:(void (^)(NSData *))dataHandler {
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
        if (httpResponse.statusCode == 200) {
            if (dataHandler != nil) {
                dataHandler(data);
            }
            else {
                [_delegate downloadCompletedWithData:data];
            }
        }
    }];
    [dataTask resume];
}

- (void)clean {
    [_session release];
    [_delegate release];
}
@end
