//
//  MPFMiddleware.m
//  MiddlewareDemo
//
//  Created by walterlee on 2019/3/25.
//  Copyright © 2019 WalterLee. All rights reserved.
//

#import "MPFMiddleware.h"

@implementation MPFBlockMiddleware

-(instancetype)initWithBlock:(MPFMiddlewareBlock)block{
    if (self = [super init]) {
        _block = [block copy];
    }
    return self;
}

-(void)context:(MPFContext *)context next:(MPFMiddlewareNext)next{
    self.block(context,next);
}

@end

@implementation MPFMiddlewareRunner

-(instancetype)initWithMiddlewares:(NSArray<id<MPFMiddleware>> *)middlewares{
    if (self = [super init]) {
        _middlewares = middlewares;
    }
    return self;
}

-(void)run:(MPFContext *)context callback:(RunMiddlewareCallback)callback{
    [self runMiddlewares:self.middlewares context:context callback:callback];
}

-(void)runMiddlewares:(NSArray<id<MPFMiddleware>>*)middlewares
              context:(MPFContext *)context
             callback:(RunMiddlewareCallback)callback{
    BOOL earlyExit = context == nil;
    if (middlewares.count == 0 || earlyExit) {
        if (callback) {
            callback(earlyExit,middlewares);
        }
        return;
    }
    
    [middlewares[0] context:context next:^(MPFContext *newContext) {
        NSArray *remainingMiddlewares = [middlewares subarrayWithRange:NSMakeRange(1, middlewares.count - 1)];
        [self runMiddlewares:remainingMiddlewares context:context callback:callback];
    }];
}


@end
