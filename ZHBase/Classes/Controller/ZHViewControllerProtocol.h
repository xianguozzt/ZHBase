//
//  ZHViewControllerProtocol.h
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZHViewModelProtocol;

@protocol ZHViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <ZHViewModelProtocol>)viewModel;
- (void)zh_bindViewModel;
- (void)zh_addSubviews;
- (void)zh_layoutNavigation;
- (void)zh_getNewData;
//- (void)recoverKeyboard;

@end
