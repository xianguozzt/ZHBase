//
//  ZHBaseViewController.m
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import "ZHBaseViewController.h"
#import "ReactiveCocoa.h"

@interface ZHBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, assign) BOOL changeStatusBarAnimated;
@property (nonatomic, assign) BOOL isCanSideBack;
@end

@implementation ZHBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    ZHBaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController zh_addSubviews];
        [viewController zh_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController zh_layoutNavigation];
        [viewController zh_getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<ZHViewModelProtocol>)viewModel {
 
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0)
                                                             forBarMetrics:UIBarMetricsDefault];
    } else {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                             forBarMetrics:UIBarMetricsDefault];
    }

    //[self setIsExtendLayout:NO];
    //if([[ZHUserInfo getPhoneName] isEqualToString:@"iPad"])
    
    [self zh_removeNavgationBarLine];
    
    //[self layoutNavigationBar:[UIImage imageNamed:@"navigationBarBG@2x.png"] titleColor:[UIColor blackColor] titleFont:[UIFont fontWithName:@"MicrosoftYaHei" size:(18)] leftBarButtonItem:nil rightBarButtonItem:nil];
    
    //if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
    //    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //}
    
    
    //self.tabBarController.tabBar.backgroundColor = self.fontModel.backgroundColor;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [self updateCurrVC];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
   
    
    
}
-(void)updateCurrVC{
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbar.translucent = NO;
    //if(![self isKindOfClass:[MainViewController class]])
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self resetNaviLeftItem];
}

-(void)resetNaviLeftItem{
    //self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.toolbar.translucent = NO;
    
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    //view.backgroundColor = [UIColor cyanColor];
    //view.userInteractionEnabled = YES;

    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"common_back_black"] forState:UIControlStateNormal];
    //[view addSubview:back];
    back.frame = CGRectMake(0, 0, 24, 44);
    @weakify(self);
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x){
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem*left = [[UIBarButtonItem alloc] initWithCustomView:back];
    [self.navigationItem setLeftBarButtonItem:left];
    self.isCanSideBack = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}
-(void)showAlertController:(NSString*)title block:(alertBlock)block{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"返回" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    if(block){
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block();
        }];
        [alertVC addAction:sureAction];
    }
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    
    return self.isCanSideBack;
}

- (void)viewWillDisappear:(BOOL)animated {
    //self.navigationItem.leftBarButtonItem = nil;
    //[HTNetWorking cancelAllRequest];
    [super viewWillDisappear:animated];
    //[self.viewModel.timeLabel start]

}
/**
 *恢复边缘返回
 */
- (void)resetSideBack {
    
    self.isCanSideBack=YES;
    //开启ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
#pragma mark - system

-(UIStatusBarStyle)preferredStatusBarStyle{
    if(self.statusbarType == 1){
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    
    return self.statusBarHidden;
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)zh_removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                }
            }
        }
    }
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}
-(void)changeNavigationBarBackgroundColor:(UIColor *)barBackgroundColor{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *subviews =self.navigationController.navigationBar.subviews;
        for (id viewObj in subviews) {
            if (@available(iOS 10.0, *)) {
                //iOS10,改变了状态栏的类为_UIBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UIBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.hidden=YES;
                }
            }else{
                //iOS9以及iOS9之前使用的是_UINavigationBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UINavigationBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.hidden=YES;
                }
            }
        }
        UIImageView *imageView = [self.navigationController.navigationBar viewWithTag:111];
        if (!imageView) {
            imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 64)];
            imageView.tag = 111;
            [imageView setBackgroundColor:barBackgroundColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController.navigationBar insertSubview:imageView atIndex:0];
            });
        }else{
            [imageView setBackgroundColor:barBackgroundColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController.navigationBar sendSubviewToBack:imageView];
            });
            
        }
        
    }
}
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}


- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}


#pragma mark - RAC
/**
 *  添加控件
 */
- (void)zh_addSubviews {}

/**
 *  绑定
 */
- (void)zh_bindViewModel {}

/**
 *  设置navation
 */
- (void)zh_layoutNavigation {
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //[self.navigationController.navigationBar setTitleTextAttributes:
    // @{NSFontAttributeName:HTSetFont(@"PingFangSC-Medium" ,20),
    //   NSForegroundColorAttributeName:self.fontModel.titleHeaderTextColor}];
    [self.navigationController.navigationBar  setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navi"]];
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"navi"]];
}
-(void)setNaviTitle:(NSString*)title{
    

}
/**
 *  初次获取数据
 */
- (void)zh_getNewData {}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)removeCameraViewController{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[NSClassFromString(@"ZHCameraPickerViewController") class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[NSClassFromString(@"PECropViewController") class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
    //for (UIViewController *temp in self.navigationController.viewControllers) {
    //    if ([temp isKindOfClass:[NSClassFromString(@"ZHCameraPickerViewController") class]]||[temp isKindOfClass:[NSClassFromString(@"PECropViewController") class]]) {
    //        [temp popoverPresentationController];
    //    }
    //}
}

-(void)removeViewController:(NSArray*)viewControllers{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (NSString *viewController in viewControllers) {
        for (UIViewController *vc in marr) {
            if ([vc isKindOfClass:[NSClassFromString(viewController) class]]) {
                [marr removeObject:vc];
                break;
            }
        }
    }
    
    self.navigationController.viewControllers = marr;
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(CGFloat)getScreenHeadHeight{
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"statusbar height: %f", rectOfStatusbar.size.height);   // 高度
    
    //（navigationbar）
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    NSLog(@"navigationbar height: %f", rectOfNavigationbar.size.height);   // 高度
    
    CGFloat left =  rectOfStatusbar.size.height + rectOfNavigationbar.size.height;
    return left;
}




- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



-(void)removeChildVc:(UIViewController*)vc {
    [vc willMoveToParentViewController:nil];
    if (![vc isViewLoaded]) {
        [vc removeFromParentViewController];
    } else {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}


@end
