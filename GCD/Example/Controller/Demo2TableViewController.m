//
//  Demo2TableViewController.m
//  GCD
//
//  Created by Charles on 17/1/9.
//  Copyright © 2017年 Charles. All rights reserved.
//

#import "Demo2TableViewController.h"
#import "CYGCDImageModel.h"

@interface Demo2TableViewController ()

@end

@implementation Demo2TableViewController{
    dispatch_group_t _group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Download four pictures sequentially, then notify the group;
    
    // (1->2->3->4)orderly ->notify
    
    self.navigationItem.title = @"Demo2(有序)";
    
    _group = dispatch_group_create();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData {
    
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
}

@end
