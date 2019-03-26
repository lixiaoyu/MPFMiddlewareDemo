//
//  ViewController.m
//  MiddlewareDemo
//
//  Created by walterlee on 2019/3/25.
//  Copyright © 2019 WalterLee. All rights reserved.
//

#import "ViewController.h"
#import "MPFMiddleware.h"
#import "FirstMiddleware.h"
#import "SecondMiddleware.h"
#import "ThirdMiddleware.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FirstMiddleware *middleware1 = [[FirstMiddleware alloc] initWithBlock:^(MPFContext *context, MPFMiddlewareNext next) {
         NSLog(@"第1个middleware执行完成");
        if (next) {
            next(context);
        }
    }];
    SecondMiddleware *middleware2 = [[SecondMiddleware alloc] initWithBlock:^(MPFContext *context, MPFMiddlewareNext next) {
        NSLog(@"第2个middleware执行完成");
        if (next) {
            next(context);
        }
    }];
    ThirdMiddleware *middleware3 = [ThirdMiddleware new];
    
    MPFContext *context = [MPFContext new];
    
    MPFMiddlewareRunner *middlewareRunner = [[MPFMiddlewareRunner alloc] initWithMiddlewares:@[middleware1,middleware2,middleware3]];
    [middlewareRunner run:context callback:^(BOOL earlyExit, NSArray<id<MPFMiddleware>> *remainingMiddlewares) {
        NSLog(@"------------分割线--------------");
        NSLog(@"全部middleware执行完成");

    }];
}


@end
