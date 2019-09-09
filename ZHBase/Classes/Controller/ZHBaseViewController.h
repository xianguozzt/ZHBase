//
//  ZHBaseViewController.h
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHViewControllerProtocol.h"


@interface ZHBaseViewController : UIViewController <ZHViewControllerProtocol>

/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
typedef void (^alertBlock)();
#pragma clang diagnostic pop

@property (assign,nonatomic) BOOL isExtendLayout;
@property (nonatomic) NSInteger statusbarType;
@property (nonatomic, assign) BOOL statusBarHidden;
/**
 * 功能：设置修改StatusBar
 * 参数：（1）StatusBar样式：statusBarStyle
 *      （2）是否隐藏StatusBar：statusBarHidden
 *      （3）是否动画过渡：animated
 */

-(void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated;


/**
 * 功能： 布局导航栏界面
 * 参数：（1）导航栏背景：backGroundImage
 *      （2）导航栏标题颜色：titleColor
 *      （3）导航栏标题字体：titleFont
 *      （4）导航栏左侧按钮：leftItem
 *      （5）导航栏右侧按钮：rightItem
 */
-(void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem;

-(void)removeCameraViewController;
//-(void)removeExerciseViewController;
-(void)removeViewController:(NSArray*)viewControllers;
-(CGFloat)getScreenHeadHeight;
-(void)showAlertController:(NSString*)title block:(alertBlock)block;
-(void)setNaviTitle:(NSString*)title;
-(void)resetNaviLeftItem;
-(void)updateCurrVC;
-(void)removeChildVc:(UIViewController*)vc ;
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;
-(void)changeNavigationBarBackgroundColor:(UIColor *)barBackgroundColor;
@end
