//
//  JCSegmentedView.h
//  CustomSegControlView
//
//  Created by Jin on 17-6-12.
//  Copyright (c) 2017年 Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCSegmentViewDelegate <NSObject>

@required

/**
 *  代理函数 获取当前下标
 *
 *  @param index 下标
 */
- (void)segmentSelectIndex:(NSInteger)index;

@end

@interface JCSegmentView : UIView

@property (assign, nonatomic) id<JCSegmentViewDelegate>delegate;

/**
 *  初始化函数
 *
 *  @param y        竖坐标高度
 *  @param titles   标题的数组
 *  @param delegate 代理
 *
 *  @return HYSegmentedControl
 */
- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate;

/**
 *  提供方法改变
 *
 *  @param index 下标
 */
- (void)changeSegmentedControlWithIndex:(NSInteger)index;

@end
