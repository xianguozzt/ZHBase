//
//  ZHTableViewCellProtocol.h
//  zhonghe
//
//  Created by 韩旭 on 2017/9/15.
//  Copyright © 2017年 韩旭. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ZHTableViewCellProtocol <NSObject>

@optional

- (void)zh_setupViews;
- (void)zh_bindViewModel;
@end
