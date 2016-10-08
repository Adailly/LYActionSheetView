//
//  LYActionSheetView.h
//  弹框
//
//  Created by yang on 16/10/2.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYActionSheetView;
// 代理协议
@protocol LYActionSheetViewDelegate <NSObject>

@optional
/**
 *  代理方法
 *
 *  @param actionSheetView 显示的view
 *  @param selectedString  选中的文字
 *  @param index           选中的顺序
 */
- (void)actionSheetView:(LYActionSheetView *)actionSheetView selectedString:(NSString *)selectedString index:(NSInteger)index;

@end

@interface LYActionSheetView : UIView

/** 取消按钮颜色*/
@property (strong, nonatomic) UIColor *actionSheetColor;

/** 代理*/
@property (weak, nonatomic) id<LYActionSheetViewDelegate> delegate;

/**
 *  创建的方法
 *
 *  @param title    标题(可选)
 *  @param delegate 代理
 *  @param array    选项
 *
 *  @return view
 */
- (instancetype)initWithTitle:(NSString *)title delegate:(id)delegate actionSheetArray:(NSArray *)array;

/**
 *  显示动画
 */
- (void)show;

@end
