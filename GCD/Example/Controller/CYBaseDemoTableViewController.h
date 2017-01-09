//
//  CYBaseDemoTableViewController.h
//  GCD
//
//  Created by Charles on 17/1/9.
//  Copyright © 2017年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYGCDImageModel;

@interface CYBaseDemoTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray <CYGCDImageModel *>*dataArray;

@property (nonatomic, strong, readonly) NSArray *urlStrs;

@end
