//
//  SrcVc.m
//  TestTodayExtensionForIOSEight
//
//  Created by Wu on 17/5/2.
//  Copyright © 2017年 Wu. All rights reserved.
//

#import "SrcVc.h"
#import "DestVc.h"

@interface SrcVc ()

@end

@implementation SrcVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  按钮点击事件
 */
- (IBAction) btnDidSelected:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ShowDestVc" sender:sender];
}

/**
 *  当 segue 执行的时候，会调用该方法
 *
 *  @param segue  联线
 *  @param sender 发送器参数
 *
 *  @note  sender 是 performSegueWithIdentifier:sender: 中的 sender 参数
 *
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DestVc *destVc = segue.destinationViewController;
    destVc.name = @"iMock";
}


@end
