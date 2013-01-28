//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "MatchismoViewController.h"

@interface MatchismoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) int flipsCount;
@end

@implementation MatchismoViewController

-(void) setFlipsCount:(int)flipsCount
{
    _flipsCount=flipsCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d",self.flipsCount];
}
- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected=!sender.isSelected;
    self.flipsCount++;
}

@end
