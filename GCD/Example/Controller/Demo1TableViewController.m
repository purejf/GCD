//
//  Demo1TableViewController.m
//  GCD
//
//  Created by Charles on 17/1/9.
//  Copyright © 2017年 Charles. All rights reserved.
//

#import "Demo1TableViewController.h"
#import "CYGCDImageTableViewCell.h"
#import "CYGCDImageModel.h"

@interface Demo1TableViewController ()

@end

@implementation Demo1TableViewController {
    dispatch_group_t _group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Download four pictures concurrency, then notify the group;
    
    // (1、2、3、4)disorder ->notify
    
    self.navigationItem.title = @"Demo1(无序)";
  
    _group = dispatch_group_create();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData {
    
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
}

@end
