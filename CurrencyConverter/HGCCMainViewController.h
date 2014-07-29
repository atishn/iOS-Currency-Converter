//
//  HGCCMainViewController.h
//  CurrencyConverter
//
//  Created by HUGE | Atish Narlawar on 7/24/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGCCMainViewController : UIViewController <UITextFieldDelegate, UICollectionViewDataSource>

// Input Field
@property (nonatomic, strong) IBOutlet UITextField *userInputField;

// Rate table with Collection View
@property (nonatomic, strong) IBOutlet UICollectionView *rateTable;

@end
