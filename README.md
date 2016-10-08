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
    
    // 或多个选项
    // 创建view
    LYActionSheetView *sheetView = [[LYActionSheetView alloc] initWithTitle:nil delegate:self actionSheetArray:@[@"小视频", @"拍照", @"从相册中选择"]];
    
    // 显示view
    [sheetView show];

效果<br>
![效果1](https://github.com/HappyyardYang/LYActionSheetView/blob/master/LYActionSheetView/LYActionSheetView/Image/ActionSheetView2.gif)<br>
![效果2](https://github.com/HappyyardYang/LYActionSheetView/blob/master/LYActionSheetView/LYActionSheetView/Image/actionSheetView.gif)