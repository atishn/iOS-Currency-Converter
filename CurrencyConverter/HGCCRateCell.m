//
//  HGCCRateCell.m
//  CurrencyConverter
//
//  Created by HUGE | Atish Narlawar on 7/24/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import "HGCCRateCell.h"

@implementation HGCCRateCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.spinner startAnimating];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
