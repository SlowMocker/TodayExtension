//
//  DoneVc.m
//  TestTodayExtensionForIOSEight
//
//  Created by Wu on 17/5/2.
//  Copyright © 2017年 Wu. All rights reserved.
//

#import "DoneVc.h"

@interface DoneVc ()

@end

@implementation DoneVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@",[self.navigationController.viewControllers lastObject]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)back:(UIStoryboardSegue *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//    NSLog(@"hello");
//}

- (IBAction)dismiss:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
