# GCD_Request
GCD的使用：多个网络请求/任务并发或顺序执行，所有的网络请求/任务都结束之后再执行数据操作。

###更多内容请移步至简书地址：[Charles姚](http://www.jianshu.com/p/e05f2afc2026)


![GCD12345.gif](http://upload-images.jianshu.io/upload_images/939127-ca8e8ad5c74fdb1c.gif?imageMogr2/auto-orient/strip)

####部分代码：
```
static NSString *const kCellID = @"kCellID";

static NSString *const kDemo1Text = @"多个网络请求/任务并发执行，所有的网络请求/任务都结束之后再执行数据操作，点击查看Demo/实例";

static NSString *const kDemo2Text = @"多个网络请求/任务顺序执行，所有的网络请求/任务都结束之后再执行数据操作，点击查看Demo/实例";
```
```
   多个网络请求/任务并发结束之后，然后再执行操作。
    // 1.
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[0]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
    });
    
    // 2.
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[1]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
    });
    
    // 3.
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[2]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
    });
    
    // 4.
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[3]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
    });
    
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
```
```
   多个网络请求/任务顺序执行结束之后，然后再执行操作。
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    // 1.
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // -1
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[0]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
        dispatch_semaphore_signal(semaphore); // + 1
    });
    
    // 2.
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[1]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
        dispatch_semaphore_signal(semaphore);
    });
    
    // 3.
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[2]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
        dispatch_semaphore_signal(semaphore);
    });
    
    // 4.
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(_group);
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrs[3]]];
        CYGCDImageModel *model = [CYGCDImageModel new];
        model.imageData = data;
        [self.dataArray addObject:model];
        dispatch_group_leave(_group);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
```
