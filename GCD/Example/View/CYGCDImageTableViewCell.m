//
//  CYGCDImageTableViewCell.m
//  GCD
//
//  Created by Charles on 17/1/9.
//  Copyright © 2017年 Charles. All rights reserved.
//

#import "CYGCDImageTableViewCell.h"
#import "CYGCDImageModel.h"

@interface CYGCDImageTableViewCell ()

@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation CYGCDImageTableViewCell

- (void)setImageModel:(CYGCDImageModel *)imageModel {
    if ([_imageModel isEqual:imageModel] && _imageModel) return;
    _imageModel = imageModel;
    if (imageModel.imageData.length) {
        UIImage *image = [UIImage imageWithData:imageModel.imageData];
        self.imgView.image = image;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imgX = 10;
    CGFloat imgY = 10;
    CGFloat imgW = self.contentView.frame.size.width - imgX * 2.0;
    CGFloat imgH = self.contentView.frame.size.height - imgY * 2.0;
    self.imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [UIImageView new];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
    }
    return _imgView;
}

@end
