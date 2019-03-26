//
//  ThirdMiddleware.m
//  MiddlewareDemo
//
//  Created by walterlee on 2019/3/26.
//  Copyright © 2019 WalterLee. All rights reserved.
//

#import "ThirdMiddleware.h"

@implementation ThirdMiddleware

-(void)context:(MPFContext *)context next:(MPFMiddlewareNext)next{
    NSLog(@"第三个middleware执行完成");
    if (next) {
        next(context);
    }
}

@end
