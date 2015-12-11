//
//  ViewController.m
//  whiteStyleAlert
//
//  Created by wordoor－z on 15/12/11.
//  Copyright © 2015年 wzx. All rights reserved.
//

#import "ViewController.h"
#import "WhiteStyleAlertView.h"
@interface ViewController ()
{
    WhiteStyleAlertView * wzx;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    wzx = [[WhiteStyleAlertView alloc]initWithFrame:self.view.frame andHeadStr:@"标题" andTitle:@"今日苹果开放ios8.2的更新，大量用户踊跃更新，导致很多用户进入app store出现无法下载应用、看不到应用商店主页面，或者是下载时候那个圈圈一直在转就是进入不了下载页面的问题！在接到用户反馈后，我们已经和苹果中国做了确认，的确是由于ios 8.2的开放下载导致流量激增所致，预计该情况将在近几天缓解，请大家不要担心！"];
    [self.view addSubview:wzx];
    [wzx addSureBtn:@"确定" andSureBlock:^{
        [wzx hide];
        NSLog(@"确定");
    } andCancelBtn:@"取消" andCancelBlock:^{
        [ wzx hide];
        NSLog(@"取消");
    }];
}
- (IBAction)btnClick:(id)sender {
    [wzx show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
