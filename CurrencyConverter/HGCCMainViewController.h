//
//  HGCCMainViewController.h
//  CurrencyConverter
//
//  Created by HUGE | Atish Narlawar on 7/24/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGCCMainViewController : UIViewController <UITextFieldDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) IBOutlet UITextField *userInputField;
@property (nonatomic, strong) IBOutlet UICollectionView *rateTable;

@end
