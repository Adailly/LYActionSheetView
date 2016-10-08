# LYActionSheetView
快速实现自定义ActionSheetView

使用方法<br>
    // 创建view
    LYActionSheetView *sheetView = [[LYActionSheetView alloc] initWithTitle:@"是否取消操作" delegate:self actionSheetArray:@[@"确认"]];
    
    // 设置选项的颜色
    sheetView.actionSheetColor = [UIColor redColor];
    
    // 显示view
    [sheetView show];

// 代理方法
- (void)actionSheetView:(LYActionSheetView *)actionSheetView selectedString:(NSString *)selectedString index:(NSInteger)index
{
    NSLog(@"%@ -- %zd", selectedString, index);
}
