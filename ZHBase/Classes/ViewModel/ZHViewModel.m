//
//  ZHViewModel.m
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import "ZHViewModel.h"
typedef NS_ENUM(NSInteger, ZhNetWorkError){
    ZHPhoneError = 0,
    ZHSmsCodeError
};
@implementation ZHViewModel



+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    ZHViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel zh_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}





- (void)zh_initialize {}

- (void)zh_refreshData {}

-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
