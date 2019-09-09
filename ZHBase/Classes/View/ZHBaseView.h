//
//  ZHBaseView.h
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZHViewProtocol.h"

@interface ZHBaseView : UIView <ZHViewProtocol>
@property(nonatomic, assign) CGSize intrinsicContentSize;
@end
