//
//  ZHBaseScrollView.m
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import "ZHBaseScrollView.h"

@interface ZHBaseScrollView()
@end
@implementation ZHBaseScrollView

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
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self zh_setupViews];
        [self zh_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<ZHViewModelProtocol>)viewModel {

    self = [super init];
    return self;
}

- (void)zh_bindViewModel {
}
-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}
- (void)zh_setupViews {
}

@end
