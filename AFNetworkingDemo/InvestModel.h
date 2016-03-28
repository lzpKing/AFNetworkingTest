//
//  InvestModel.h
//  AllCapitalPro
//
//  Created by chenjiahe on 15/8/13.
//  Copyright (c) 2015年 chenjiahe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestModel : NSObject
@property(nonatomic,strong)NSString * itemBulkLoanPeriod;//7天
@property(nonatomic,strong)NSString * itemTestAnnualIncome;//18%
@property(nonatomic,strong)NSString * itemTestLoanDescription;//产品介绍
@property(nonatomic,strong)NSString * itemTestProfitIntroduce;//收益介绍
@property(nonatomic,strong)NSString * itemTestRepaymentMethod;//再次投标返现
@property(nonatomic,strong)NSString * itemTestSafeguardMode;//购买当日


@property(nonatomic,strong)NSString * itemCount;
@property(nonatomic,strong)NSString * itemBulkLoanID;
@property(nonatomic,strong)NSString * itemLoanTitle;
@property(nonatomic,strong)NSString * itemLoanRepayment;
@property(nonatomic,strong)NSString * itemBulkLoanStatus;
@property(nonatomic,strong)NSString * itemComprehensiveRate;
@property(nonatomic,strong)NSString * itemLoanTerm;
@property(nonatomic,strong)NSString * itemType;
@property(nonatomic,strong)NSString * itemLoanAmount;
@property(nonatomic,strong)NSString * itemBulkLoanNumber;
@property(nonatomic,strong)NSString * itemCustNo;
@property(nonatomic, strong)NSString *loanAmount;//投资本金
@property (nonatomic, strong)NSString * itemProgress;
//我的记录
@property(nonatomic,strong)NSString * itemEarned;
@property(nonatomic,strong)NSString * itemCapital_Interest;
@property(nonatomic,strong)NSString * itemAccountBalance;
@property(nonatomic,strong)NSString * itembuklFlowNoStr;
@property(nonatomic,strong)NSString * itemTenderIncreaseAmount;//倍数
@property(nonatomic,strong)NSString * itemterderMinAmount;//倍数
//好乱的说 有一个样字段名字 无需重建

@property(nonatomic, strong)NSString *bulkLoanNumber;//散标详情信息



//还款详情的model
@property (nonatomic, strong)NSString *itemRepaymentSeq;//还款期数
@property (nonatomic, strong)NSString *itemRepaymentCapital;//应还本金
@property (nonatomic, strong)NSString *itemRepaymentInterest;//应还利息
@property (nonatomic, strong)NSString *itemRepaymentTime;//实际还款日期
@property (nonatomic, strong)NSString *itemInfactRepaymentPricipal;//实际还款本息
@property (nonatomic, strong)NSString *itemRepaymentStatus;//还款状态 00未还款，01正常还款，02还款中
@property (nonatomic, strong)NSString *itemInfactEarnInterest;//实际
@property (nonatomic, strong)NSString *itemInfactRepaymentTime;//实际
@property (nonatomic, strong)NSString *itemOverdueamount;//罚息


//轮播图
@property(nonatomic,strong)NSString * itemActivityUrl;
@property(nonatomic, strong)NSString *itemIndexPic;

@property(nonatomic,strong)NSMutableArray * LoanApply;


@end
