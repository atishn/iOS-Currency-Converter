//
//  HGCCMainViewController.m
//  CurrencyConverter
//
//  Created by HUGE | Atish Narlawar on 7/24/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import "HGCCMainViewController.h"
#import "HGCCRateCell.h"

@interface HGCCMainViewController ()

@end

@implementation HGCCMainViewController

#pragma mark - view lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName: @"HGCCRateCell" bundle:nil];
    
    [self.rateTable registerNib:cellNib forCellWithReuseIdentifier:@"rateCell"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - text field delegate methods


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"Text field has changed");
    
    return YES;
}

#pragma mark - collection view methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rateCell" forIndexPath:indexPath];
    [newCell.contentView setBackgroundColor:[UIColor redColor]];
    return newCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 200);
}



@end
