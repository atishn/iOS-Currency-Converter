//
//  HGCCMainViewController.m
//  CurrencyConverter
//
//  Created by HUGE | Atish Narlawar on 7/24/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import "HGCCMainViewController.h"
#import "HGCCRateCell.h"
#import <AFNetworking/AFNetworking.h>

@interface HGCCMainViewController ()

@property (nonatomic, strong) NSMutableArray *currencyRates;
@property (nonatomic, strong) NSArray *currencyStrings;
@property (nonatomic, assign) float exchangeValue;
@property (nonatomic, assign) int loadCount;

@end


static const NSString *API_BASE_URL = @"http://rate-exchange.appspot.com/currency?from=USD&to=";
static const int FAILURE_VALUE = -1;
static const int ROW_HEIGHT = 37;
static const NSString *NUMBERS_ONLY = @"1234567890";



@implementation HGCCMainViewController

#pragma mark - view lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _currencyStrings = @[@"GBP", @"EUR", @"JPY", @"BRL"];

        NSNumber *emptyRate = [NSNumber numberWithInt:0];
        _currencyRates = [@[emptyRate,emptyRate,emptyRate,emptyRate] mutableCopy]; // Empty with Mutable copies for further changes.

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadRateData];

    UINib *cellNib = [UINib nibWithNibName: @"HGCCRateCell" bundle:nil];
    [self.rateTable registerNib:cellNib forCellWithReuseIdentifier:@"rateCell"];
    [self.rateTable reloadData];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - internal methods. Load rates

- (void) loadRateData {

    __block NSMutableArray *blockRates = self.currencyRates;

    for (int i = 0; i < self.currencyStrings.count; ++i) {
        NSString *composedEndPoint = [NSString stringWithFormat:@"%@%@", API_BASE_URL, [self.currencyStrings objectAtIndex:i]];

        [[AFHTTPRequestOperationManager manager] GET:composedEndPoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSNumber *loadRate = [NSNumber numberWithFloat:[[responseObject objectForKey:@"rate"] floatValue]];
            blockRates[i] = loadRate;

        } failure:^(AFHTTPRequestOperation *operation, NSError *error){

           NSNumber *failureRate = [NSNumber numberWithInt:FAILURE_VALUE];
            blockRates[i] = failureRate;
        }];
        self.loadCount ++;
    }


}


#pragma mark - text field delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    
    if (textField == self.userInputField) {

        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        // Input Validation.
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:[NUMBERS_ONLY copy]] invertedSet];

        // Avoid user to insert characters.
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([cs characterIsMember:c]) {
                return NO;
            }
        }

        // Filter the value.
        NSString *filtered = [[newText componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        self.exchangeValue = [filtered floatValue];
        [self.rateTable reloadData];
        
        return YES;
    } else {
        return NO;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


#pragma mark - collection view methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

   if((self.loadCount == self.currencyRates.count) && self.exchangeValue > 0){
       return self.currencyRates.count;
   } else{
       return 1;
   }
}

- (UICollectionViewCell *)collectionView : (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HGCCRateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rateCell" forIndexPath:indexPath];

    if((self.loadCount == self.currencyRates.count) && self.exchangeValue > 0) {
        NSNumber *cellRate = [self.currencyRates objectAtIndex:indexPath.row];
        NSNumber *cellCurrency = [self.currencyStrings objectAtIndex:indexPath.row];

        if([cellRate floatValue] > 0){
            float convertedRate = self.exchangeValue * [cellRate floatValue];
            cell.cellText.text = [NSString stringWithFormat:@"%@ : %0.2f", cellCurrency, convertedRate];

        } else{
            cell.cellText.text = [NSString stringWithFormat:@"%@ : %@", cellCurrency, NSLocalizedString(@"error loading", @"error loading text")];
        }
        cell.backgroundColor = [UIColor redColor];
        [cell.spinner stopAnimating];
    } else {

        if(self.loadCount < self.currencyRates.count){

        } else{
            cell.cellText.text = NSLocalizedString(@"Enter a value above", @"User hasn't enter  a value text");
            [cell.spinner stopAnimating];
        }
    }
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.rateTable.bounds.size.width, ROW_HEIGHT);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
