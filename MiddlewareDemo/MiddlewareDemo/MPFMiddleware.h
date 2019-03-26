//
//  MPFMiddleware.h
//  MiddlewareDemo
//
//  Created by walterlee on 2019/3/25.
//  Copyright © 2019 WalterLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPFContext.h"

typedef void(^MPFMiddlewareNext) (MPFContext * newContext);

@protocol MPFMiddleware <NSObject>
@required
-(void)context:(MPFContext *)context next:(MPFMiddlewareNext)next;

@end

typedef void(^MPFMiddlewareBlock) (MPFContext *context,MPFMiddlewareNext next);

@interface MPFBlockMiddleware : NSObject <MPFMiddleware>
@property(nonatomic,readonly)MPFMiddlewareBlock block;

-(instancetype)initWithBlock:(MPFMiddlewareBlock)block;

@end

typedef void (^RunMiddlewareCallback) (BOOL earlyExit,NSArray<id<MPFMiddleware>> *remainingMiddlewares);

@interface MPFMiddlewareRunner : NSObject

@property(nonatomic,strong)NSArray<id<MPFMiddleware>> *middlewares;

-(instancetype)initWithMiddlewares:(NSArray<id<MPFMiddleware>> *)middlewares;

-(void)run:(MPFContext *)context callback:(RunMiddlewareCallback)callback;

@end


