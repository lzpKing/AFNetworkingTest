//
//  NewsTableViewCell.h
//  AllCapitalPro
//
//  Created by chenjiahe on 15/8/7.
//  Copyright (c) 2015年 chenjiahe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *investTitle;
@property (weak, nonatomic) IBOutlet UILabel *percentNum;
@property (weak, nonatomic) IBOutlet UILabel *monthNum;
@property (weak, nonatomic) IBOutlet UILabel *moneyNum;
@property (weak, nonatomic) IBOutlet UIImageView *blueImg;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end
