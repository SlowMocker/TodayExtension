//
//  ImageVc.m
//  TestTodayExtensionForIOSEight
//
//  Created by Wu on 17/4/27.
//  Copyright © 2017年 Wu. All rights reserved.
//

#import "ImageVc.h"

@interface ImageVc ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 很有可能在给 self.image 赋值时 imageView 还并未加载
    if (!self.imageView.image) {
        [self.imageView setImage:_image];
    }
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

- (void) setImage:(UIImage *)image {
    if (image) {
        _image = image;
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
//            NSLog(@"此时 imageView 是否存在: %@",self.imageView ? @"YES" : @"NO");
            [self.imageView setImage:_image];
        });
    }
}

@end
