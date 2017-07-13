//
//  ZHTextView.h
//  ZHTextView
//
//  Created by 李保征 on 2017/7/12.
//  Copyright © 2017年 李保征. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 自动调整类型 */
typedef NS_ENUM(NSInteger, AutoAdjustType) {
    AutoAdjustType_Bottom     = 0,
    AutoAdjustType_Top      = 1,
};

@interface ZHTextView : UITextView

@property (nonatomic, copy) NSString *placehoder;

@property (nonatomic, strong) UIColor *placehoderColor;

#pragma mark - AutoAdjust

@property (nonatomic,assign) BOOL isAutoAdjustHeight;

@property (nonatomic,assign) AutoAdjustType autoAdjustType;

@property (nonatomic,assign) CGFloat limitMaxHeight;

@end
