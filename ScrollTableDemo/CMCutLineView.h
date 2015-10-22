//
//  CMCutLineView.h
//  canmou_c
//
//  Created by JiFeng on 15/10/17.
//  Copyright © 2015年 Canmou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCutLineView : UIView
- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor alpha:(CGFloat)alpha isDashLine:(BOOL)isDashLine lineWidth:(CGFloat)lineWidth;
@end
