//
//  ZHViewModelProtocol.h
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
@protocol ZHViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

@property (nonatomic, strong, readonly) RACSubject *errors;

@property (nonatomic, copy) NSString *currentVCName;
/**
 *  0 不需要更新 1 需要更新
 */
@property (nonatomic, copy) NSString *canLayOutUI;

/**
 *  初始化
 */
- (void)zh_initialize;

/**
 *  更新UI
 */
- (void)zh_refreshUI;

@end
