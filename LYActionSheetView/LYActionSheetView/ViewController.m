//
//  ViewController.m
//  LYActionSheetView
//
//  Created by yang on 16/10/8.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "ViewController.h"
#import "LYActionSheetView.h"

@interface ViewController ()<LYActionSheetViewDelegate>

- (IBAction)ShowActionSheetView:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)ShowActionSheetView:(UIButton *)sender
{
    // 创建view
    LYActionSheetView *sheetView = [[LYActionSheetView alloc] initWithTitle:nil delegate:self actionSheetArray:@[@"小视频", @"拍照", @"从相册中选择"]];
    
    // 显示view
    [sheetView show];

//    // 创建view
//    LYActionSheetView *sheetView = [[LYActionSheetView alloc] initWithTitle:@"是否取消操作" delegate:self actionSheetArray:@[@"确认"]];
//    
//    // 设置选项的颜色
//    sheetView.actionSheetColor = [UIColor redColor];
//    
//    // 显示view
//    [sheetView show];
}

// 代理方法
- (void)actionSheetView:(LYActionSheetView *)actionSheetView selectedString:(NSString *)selectedString index:(NSInteger)index
{
    NSLog(@"%@ -- %zd", selectedString, index);
}

@end
