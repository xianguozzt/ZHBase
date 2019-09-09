//
//  ZHBaseNavigationController.m
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import "ZHBaseNavigationController.h"
@interface ZHBaseNavigationController ()<UINavigationBarDelegate>
@property (nonatomic) NSString *lastClass;
@end

@implementation ZHBaseNavigationController



- (BOOL)shouldAutorotate {
    
    BOOL result = self.viewControllers.lastObject.shouldAutorotate;
    return result;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    UIInterfaceOrientationMask mask =  self.viewControllers.lastObject.supportedInterfaceOrientations;
    return mask;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    UIInterfaceOrientation ori =  self.viewControllers.lastObject.preferredInterfaceOrientationForPresentation;
    return ori;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = true;
        
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}


@end
