//
//  ZHView.m
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import "ZHView.h"

@implementation ZHView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self zh_setupViews];
        [self zh_bindViewModel];
    }
    return self;
}

- (void)zh_bindViewModel {
}

- (void)zh_setupViews {
}


-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
