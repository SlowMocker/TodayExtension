//
//  TodayViewController.m
//  TestTodayExtension
//
//  Created by Wu on 17/4/27.
//  Copyright © 2017年 Wu. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *curImageIndex;
@property (strong, nonatomic) IBOutlet UILabel *isLatestImage;

@end

@implementation TodayViewController
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark event response
- (IBAction)goContainingApp:(id)sender {
    // 设置 Containing App 的 URL Scheme 为 imcoktestextension
    // 可以在 scheme 后面添加一些信息传递给 Containing App
    // Containing App 通过 - (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options 来获取 url
    NSString *customURL =@"imcoktestextension://ShowImage";
    NSURL *openURL = [NSURL URLWithString:customURL];
    NSExtensionContext *exContext = self.extensionContext; // 扩展执行的上下文环境 开发人员无需关心
    [exContext openURL:openURL completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"success");
        }
        else {
            NSLog(@"fail");
        }
    }];
}

#pragma mark
#pragma mark NCWidgetProviding
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    if ([(NSNumber *)[self appGroupsReadDataByUserDefaultForKey:@"indexEx"] isEqual:(NSNumber *)[self appGroupsReadDataByUserDefaultForKey:@"index"]]) {
        // 读取缓存数据（未做缓存）
        completionHandler(NCUpdateResultNoData);
    }
    else {
        [self loadImageWithUrl:[self appGroupsReadDataByUserDefaultForKey:@"url"]];
        completionHandler(NCUpdateResultNewData);
    }
}

- (UIEdgeInsets) widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    self.preferredContentSize = CGSizeMake(0, 70);
    return UIEdgeInsetsZero;
}

#pragma mark
#pragma mark private methods

- (void) loadImageWithUrl:(NSString *)path {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:path];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            dispatch_queue_t mainQ = dispatch_get_main_queue();
            dispatch_async(mainQ, ^{
                self.curImageIndex.text = [NSString stringWithFormat:@"当前图片索引: %ld",((NSNumber *)[self appGroupsReadDataByUserDefaultForKey:@"index"]).integerValue];
                self.isLatestImage.text = @"当前是最新图片";
                [self.imageView setImage:[UIImage imageWithData:data]];
            });
        }
    }];
    [task resume];
}


// 使用偏好设置存取共享数据
- (id) appGroupsReadDataByUserDefaultForKey:(NSString *)key {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.iMockTest"];
    NSString *value = [shared valueForKey:key];
    return value;
}

- (void) appGroupsSaveDataByNSUserDefaults:(id)value toKey:(NSString *)key {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.iMockTest"];
    [shared setObject:value forKey:key];
    [shared synchronize];
}

// 使用 NSFileManager 存取共享数据

@end
