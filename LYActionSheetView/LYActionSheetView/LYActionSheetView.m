//
//  LYActionSheetView.m
//  弹框
//
//  Created by yang on 16/10/2.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "LYActionSheetView.h"

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define bgColor HEXCOLOR(0xf4f5f7)
#define tColor HEXCOLOR(0x222222)
#define buttonType 100

@interface LYActionSheetView ()

/** 菜单背景*/
@property (strong, nonatomic) UIView *backView;
/** 菜单栏告诉*/
@property (assign, nonatomic) CGFloat height;
/** 数组*/
@property (strong, nonatomic) NSArray *stringArray;
/** 取消按钮*/
@property (weak, nonatomic) UIButton *cancelButton;

@end

@implementation LYActionSheetView

- (instancetype)initWithTitle:(NSString *)title delegate:(id)delegate actionSheetArray:(NSArray *)array
{
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    if (self) {
        self.alpha = 0;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = delegate;
        self.stringArray = [NSArray arrayWithArray:array];
        
        // 灰色背景
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.2;
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
        [self addSubview:view];
        
        NSInteger count = array.count;
        if (title) {
            count += 1;
        }
        self.height = count * 45 + 55;
        
        // 菜单栏
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = bgColor;
        self.backView.frame = CGRectMake(0, screenHeight, screenWidth, self.height);
        [self addSubview:self.backView];
        
        if (title) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(0, 0, screenWidth, 45);
            titleLabel.text = title;
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.textColor = [UIColor darkGrayColor];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.numberOfLines = 0;
            [self.backView addSubview:titleLabel];
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = bgColor;
            lineView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), self.frame.size.width, 1);
            [self.backView addSubview:lineView];
        }
        
        
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [self creatButtonWithTitle:array[i] target:self action:@selector(actionSheetButtonAction:) type:i];
            CGFloat btnY;
            if (title) {
                btnY = 46 + i * 45;
            } else {
                btnY = i * 45;
            }
            button.frame = CGRectMake(0, btnY, screenWidth, 45);
            [self.backView addSubview:button];
            
            // 分割线
            if (i > 0) {
                UIView *lineView = [[UIView alloc] init];
                lineView.backgroundColor = bgColor;
                lineView.frame = CGRectMake(0, btnY, self.frame.size.width, 1);
                [self.backView addSubview:lineView];
            }
        }
        
        // 分割线
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, count * 45,screenWidth, 5)];
        grayView.backgroundColor = bgColor;
        [self.backView addSubview:grayView];
        
        UIButton *cancelButton = [self creatButtonWithTitle:@"取消" target:self action:@selector(hideView) type:-1];
        cancelButton.frame = CGRectMake(0, grayView.frame.origin.y + 5, screenWidth, 50);
        self.cancelButton = cancelButton;
        [self.backView addSubview:self.cancelButton];
    }
    return self;
}

- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
        self.backView.transform = CGAffineTransformMakeTranslation(0, -self.height);
    }];
}

- (void)hideView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
        self.backView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setActionSheetColor:(UIColor *)actionSheetColor
{
    _actionSheetColor = actionSheetColor;
    
    for (int i = 0 ; i < self.backView.subviews.count; i++) {
        UIView *view = self.backView.subviews[i];
        if ([view isKindOfClass:[UIButton class]]) {
            if (i == self.backView.subviews.count - 1) {
                continue;
            }
            [(UIButton *)view setTitleColor:actionSheetColor forState:(UIControlStateNormal)];
            [(UIButton *)view setTitleColor:actionSheetColor forState:(UIControlStateHighlighted)];
        }
    }
}

- (UIButton *)creatButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action type:(NSInteger)type
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = buttonType + type;
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitle:title forState:(UIControlStateHighlighted)];
    [button setTitleColor:tColor forState:(UIControlStateNormal)];
    [button setTitleColor:tColor forState:(UIControlStateHighlighted)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}

- (void)actionSheetButtonAction:(UIButton *)button
{
    NSInteger index = button.tag - buttonType;
    NSString *string = self.stringArray[index];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheetView:selectedString:index:)]) {
        [self.delegate actionSheetView:self selectedString:string index:index];
        [self hideView];
    }
}

@end
