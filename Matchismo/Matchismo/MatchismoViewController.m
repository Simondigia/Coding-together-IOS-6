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
@property(strong,nonatomic) PlayingDeck* deck;
@end
@implementation MatchismoViewController
-(PlayingDeck *) deck
{
    if (!_deck) {
        _deck = [[PlayingDeck alloc] init];
    }
    
    return _deck;
}


-(void) setFlipsCount:(int)flipsCount
{
    _flipsCount=flipsCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d",self.flipsCount];
}
- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected=!sender.isSelected;
    if(!sender.isSelected){
        Card *card=[self.deck drawRandomCard];
        if(card){
            [sender setTitle:card.contents forState:UIControlStateSelected];
        }
      }
    self.flipsCount++;
}

@end
