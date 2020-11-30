//
//  ViewController.m
//  NSOperation
//
//  Created by Luminous on 2020/11/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
 子线程内执行A,B,C,D,E五个任务，B依赖于A的完成，E依赖于C,D的完成，B和E都完成后，在主线程打印“任务全部完成”
 */
    
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //封装操作
    NSBlockOperation *opA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A-----------%@",[NSThread currentThread]);

    }];

    NSBlockOperation *opB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"B-----------%@",[NSThread currentThread]);

    }];

    NSBlockOperation *opC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"C-----------%@",[NSThread currentThread]);

    }];

    NSBlockOperation *opD = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"D-----------%@",[NSThread currentThread]);

    }];

    NSBlockOperation *opE = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"E-----------%@",[NSThread currentThread]);

    }];


    // 添加操作依赖能控制多任务并发的执行顺序，不能设置循环依赖,可以跨队列添加依赖
    [opB addDependency:opA];

    [opE addDependency:opC];

    [opE addDependency:opD];


    //添加到队列中
    [queue addOperations:@[opA, opB, opC, opD, opE] waitUntilFinished:YES];
    NSLog(@"任务全部完成");
}


@end
