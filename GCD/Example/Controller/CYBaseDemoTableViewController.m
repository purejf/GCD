//
//  CYBaseDemoTableViewController.m
//  GCD
//
//  Created by Charles on 17/1/9.
//  Copyright © 2017年 Charles. All rights reserved.
//

#import "CYBaseDemoTableViewController.h"
#import "CYGCDImageTableViewCell.h"

@interface CYBaseDemoTableViewController ()

@property (nonatomic, strong) NSArray *urlStrs;

@end

static NSString *kCellID = @"CYGCDImageTableViewCellID";

@implementation CYBaseDemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[CYGCDImageTableViewCell class] forCellReuseIdentifier:kCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CYGCDImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    cell.imageModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (NSMutableArray *)dataArray {
    return !_dataArray ? _dataArray = [NSMutableArray new] : _dataArray;
}

- (NSArray *)urlStrs {
    if (!_urlStrs) {
        _urlStrs = @[@"http://img.juimg.com/tuku/yulantu/130904/328512-130Z41J34638.jpg",
                     @"http://img05.tooopen.com/images/20140805/sy_68194794777.jpg",
                     @"http://img.taopic.com/uploads/allimg/140814/240410-140Q40F92258.jpg",
                     @"http://img.taopic.com/uploads/allimg/140814/240410-140Q406492266.jpg"];
    }
    return _urlStrs;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
