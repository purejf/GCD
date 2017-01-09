//
//  ViewController.m
//  GCD
//
//  Created by Charles on 17/1/9.
//  Copyright © 2017年 Charles. All rights reserved.
//

#import "ViewController.h"
#import "Demo1TableViewController.h"
#import "Demo2TableViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

static NSString *const kCellID = @"kCellID";

static NSString *const kDemo1Text = @"多个网络请求/任务并发执行，所有的网络请求/任务都结束之后再执行数据操作，点击查看Demo/实例";

static NSString *const kDemo2Text = @"多个网络请求/任务顺序执行，所有的网络请求/任务都结束之后再执行数据操作，点击查看Demo/实例";

@implementation ViewController {
    dispatch_group_t _group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"GCD在多个网络请求/任务情况下的使用";
    
    [self tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = kDemo1Text;
        } break;
        case 1: {
            cell.textLabel.text = kDemo2Text;
        } break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            Demo1TableViewController *demo1 = [Demo1TableViewController new];
            [self.navigationController pushViewController:demo1 animated:YES];
        } break;
        case 1: {
            Demo2TableViewController *demo2 = [Demo2TableViewController new];
            [self.navigationController pushViewController:demo2 animated:YES];
        } break;
        default:
            break;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 80.0;
    }
    return _tableView;
}

@end
