//
//  NPNewsTableViewCell.h
//  AllCapitalPro
//
//  Created by 西瓜 on 15/11/20.
//  Copyright © 2015年 chenjiahe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *investTitle;
@property (weak, nonatomic) IBOutlet UILabel *percentNum;
@property (weak, nonatomic) IBOutlet UILabel *monthNum;
@property (weak, nonatomic) IBOutlet UILabel *moneyNum;
@property (weak, nonatomic) IBOutlet UIImageView *starImg;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shuImg1;
@property (weak, nonatomic) IBOutlet UIImageView *shuImg2;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@end
