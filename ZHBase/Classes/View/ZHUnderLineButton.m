//
//  ZHUnderLineButton.m
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import "ZHUnderLineButton.h"
@interface ZHUnderLineButton()
@property (nonatomic) UIView *vLine;
@end
@implementation ZHUnderLineButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)buttonWithType:(UIButtonType)buttonType{
    ZHUnderLineButton *ccButton = [super buttonWithType:buttonType];
    if (ccButton) {
        CGRect frame = ccButton.frame;
        frame.origin.y = frame.origin.y + frame.size.height - 1;
        frame.size.height = 1;
        ccButton.vLine.frame = frame;
    }
    return ccButton;
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected){
        self.vLine.hidden = NO;
    }else{
        self.vLine.hidden = YES;
    }
    self.vLine.backgroundColor = [self titleColorForState:UIControlStateSelected];
}
-(UIView *)vLine{
    if (!_vLine){
        _vLine = [[UIView alloc] init];
        [self addSubview:_vLine];
        _vLine.hidden = YES;
    }
    return _vLine;
}
@end
