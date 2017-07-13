//
//  ViewController.m
//  ZHTextView
//
//  Created by 李保征 on 2017/7/12.
//  Copyright © 2017年 李保征. All rights reserved.
//

#import "ViewController.h"
#import "ZHTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZHTextView *textView = [[ZHTextView alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    textView.placehoder = @"你好";
    textView.isAutoAdjustHeight = YES;
    textView.limitMaxHeight = 100;
//    textView.autoAdjustType = AutoAdjustType_Top;
    textView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
