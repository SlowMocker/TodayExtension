//
//  HomeVc.m
//  TestTodayExtensionForIOSEight
//
//  Created by Wu on 17/4/27.
//  Copyright © 2017年 Wu. All rights reserved.
//

#import "HomeVc.h"
#import "ImageVc.h"

#define kImgUrl1 @"http://omfcs27a3.bkt.clouddn.com/appEx2.1.png"
#define kImgUrl2 @"http://omfcs27a3.bkt.clouddn.com/appEx2.2.png"
#define kImgUrl3 @"http://omfcs27a3.bkt.clouddn.com/appEx2.3.png"
#define kNotificationShowImage @"showImageNotification"

@interface HomeVc ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;

@property (nonatomic , strong) UIImage *curImg;/**< 当前图像 */

@end

@implementation HomeVc
{
    NSInteger _imageIndex;/**< 请求图片索引 */
    NSArray *_imageUrls;/**< 请求图片的 url 集合 */
}

#pragma mark
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.curImg = [UIImage new];
    _imageUrls = @[kImgUrl1 , kImgUrl2 , kImgUrl3];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goShowImage:) name:kNotificationShowImage object:nil];
        NSLog(@"添加通知");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) goShowImage:(NSNotification *)notification {
    NSLog(@"执行通知");
    // 根据实际情况给数据（未做）
    ImageVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageVc"];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark
#pragma mark event response
- (IBAction) loadNewImage:(id)sender {
    [self showLoading];
    
    [self loadImageWithIndex: _imageIndex];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"ShowLatestImage"]) {
        ImageVc *imgVc = segue.destinationViewController;
        imgVc.image = self.curImg;
    }
}

#pragma mark
#pragma mark private methods
- (void) showLoading {
    [self.loading startAnimating];
}

- (void) hiddenLoading {
    [self.loading stopAnimating];
}

- (void) loadImageWithIndex:(NSInteger)index {
    [self setImageIndex:++_imageIndex];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:_imageUrls[index]];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            [self hiddenLoading];
            self.tipLabel.text = [NSString stringWithFormat:@"当前显示的图片 index : %ld",index + 1];
        });
        
        if (data) {
            self.curImg = [UIImage imageWithData:data];
            [self appGroupsSaveDataByNSUserDefaults:_imageUrls[index] toKey:@"url"];
            if (![self appGroupsReadDataByUserDefaultForKey:@"urlEx"]) {
                [self appGroupsSaveDataByNSUserDefaults:_imageUrls[index] toKey:@"urlEx"];
            }
            [self appGroupsSaveDataByNSUserDefaults:@(index) toKey:@"index"];
            if (![self appGroupsReadDataByUserDefaultForKey:@"indexEx"]) {
                [self appGroupsSaveDataByNSUserDefaults:@(index) toKey:@"indexEx"];
            }
        }
    }];
    [task resume];
}

#pragma mark
#pragma mark setters
- (void) setImageIndex:(NSInteger) index {
    if (index > 2) {
        index = 0;
    }
    _imageIndex = index;
}

- (void) setCurImg:(UIImage *)curImg {
    if (curImg) {
        _curImg = curImg;
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            [self.imageView setImage:_curImg];
        });
    }
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
