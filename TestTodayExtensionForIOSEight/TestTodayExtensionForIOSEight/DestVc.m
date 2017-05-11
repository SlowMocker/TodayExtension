//
//  DestVc.m
//  TestTodayExtensionForIOSEight
//
//  Created by Wu on 17/5/2.
//  Copyright © 2017年 Wu. All rights reserved.
//

#import "DestVc.h"

@interface DestVc ()

@end

@implementation DestVc /*<UITraitEnvironment>*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPresentationController *controller = [UIPresentationController new];

    [[UIView appearanceWhenContainedInInstancesOfClasses:@[[DestVc class]]] setTintColor:[UIColor redColor]];
    
}

- (void) willTransitionToTraitCollection:(UITraitCollection *)collection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@",self.name);
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

@end
