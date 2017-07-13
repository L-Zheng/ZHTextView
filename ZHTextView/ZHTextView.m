//
//  ZHTextView.m
//  ZHTextView
//
//  Created by 李保征 on 2017/7/12.
//  Copyright © 2017年 李保征. All rights reserved.
//

#import "ZHTextView.h"

@interface ZHTextView ()

@property (nonatomic, strong) UILabel *placehoderLabel;

@property (nonatomic,assign) CGRect originFrame;

@end

@implementation ZHTextView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.placehoderLabel];
        
        self.originFrame = frame;
        self.placehoderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:14];
        self.limitMaxHeight = MAXFLOAT;
        self.scrollEnabled = YES;
        
        // 监听内部文字改变( 不要用代理 不要设置自己的代理为自己本身)
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

#pragma mark - getter

- (UILabel *)placehoderLabel{
    if (!_placehoderLabel) {
        _placehoderLabel = [[UILabel alloc] init];
        _placehoderLabel.numberOfLines = 0;
        _placehoderLabel.backgroundColor = [UIColor clearColor];
    }
    return _placehoderLabel;
}

#pragma mark - Setter

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)setPlacehoder:(NSString *)placehoder{
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = placehoder;
    
    [self setNeedsLayout];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor{
    _placehoderColor = placehoderColor;

    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placehoderLabel.font = font;
    
    [self setNeedsLayout];
}

#pragma mark - action

- (void)textDidChange{
    // text属性：只包括普通的文本字符串
    // attributedText：包括了显示在textView里面的所有内容（表情、text）
    self.placehoderLabel.hidden = self.hasText;
    
    //根据内容自动调整高度
    [self autoAdjustHeight];
}

#pragma mark - Private

- (void)autoAdjustHeight{
    if (self.isAutoAdjustHeight) {
        
        CGSize constraintSize = CGSizeMake(self.bounds.size.width, MAXFLOAT);
        CGSize contentSize = [self sizeThatFits:constraintSize];
        
//        NSLog(@"--适应高度--%f--",contentSize.height);
        
        CGFloat limitMinHeight = self.originFrame.size.height;
        CGFloat limitMaxHeight = self.limitMaxHeight;
        
        if (contentSize.height <= limitMinHeight) {
            //     < 自身高度
            contentSize.height = limitMinHeight;
            
        }else if (contentSize.height >= limitMaxHeight){
            //    > 最大限制高度
            contentSize.height = limitMaxHeight;
            self.scrollEnabled = YES;
            
        }else{
            //自身高度< ~ < 最大限制高度
            self.scrollEnabled = NO;
            
        }
        
//        NSLog(@"--实际高度--%f--",contentSize.height);
//        NSLog(@"--------------------");
        
        CGRect targetFrame;
        
        switch (self.autoAdjustType) {
            case AutoAdjustType_Top:
                targetFrame = CGRectMake(self.frame.origin.x, CGRectGetMaxY(self.originFrame) - contentSize.height, self.frame.size.width, contentSize.height);
                break;
            case AutoAdjustType_Bottom:
                targetFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, contentSize.height);
                break;
                
            default:
                break;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self.frame = targetFrame;
        }];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat placehoderLabelX = 5;
    CGFloat placehoderLabelY = 8;
    CGFloat placehoderLabelW = self.bounds.size.width - 2 * placehoderLabelX;
    
    CGSize maxSize = CGSizeMake(placehoderLabelW, MAXFLOAT);
    CGSize placehoderSize = [self.placehoder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placehoderLabel.font} context:nil].size;
    CGFloat placehoderLabelH = placehoderSize.height;
    
    self.placehoderLabel.frame = CGRectMake(placehoderLabelX, placehoderLabelY, placehoderLabelW, placehoderLabelH);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
