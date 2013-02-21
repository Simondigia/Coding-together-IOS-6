//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "MatchismoViewController.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
@interface MatchismoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) int flipsCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeType;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (strong,nonatomic) GameResult *gameResult;

@end
@implementation MatchismoViewController

-(GameResult *) gameResult
{
    if(!_gameResult) _gameResult=[[GameResult alloc] init];
    return _gameResult;
}
-(CardMatchingGame*) game{
    if(!_game) {_game=[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
        _game.mode=2;
    }
    return _game;
}
- (IBAction)changeMode:(UISegmentedControl *)sender {
    if( [sender selectedSegmentIndex] ) self.game.mode=3;
    else self.game.mode=2;
}

- (IBAction)newGame:(UIButton*)sender {
    //Moglo je samo da se postavi na nil
    self.game=nil;
    self.flipsCount=0;
    self.modeType.enabled=YES;
    [self updateUI:@""];
    
}


-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons=cardButtons;
    //UIImage *backImage=[UIImage imageNamed:@"Blue_back.jpg"];
    //UIImage *empty=[[UIImage alloc]init];
   
    for(UIButton *cardButton in self.cardButtons){
        [cardButton setTitle:@"" forState:UIControlStateNormal];
    }
    [self updateUI:[NSString stringWithFormat:@""]];
}

- (void) updateUI:(NSString*)description
{
    if(self.flipsCount) self.modeType.enabled=NO;
    UIImage *backImage=[UIImage imageNamed:@"Blue_back.jpg"];
    self.description.text=description;
    for(UIButton *cardButton in self.cardButtons)
    {
        Card *card=[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:[card.contents string] forState:UIControlStateSelected];
        [cardButton setTitle:[card.contents string] forState:UIControlStateSelected| UIControlStateDisabled];
        cardButton.selected=card.isFaceUp;
        cardButton.enabled=!card.isUnplayable;
        cardButton.alpha=card.isUnplayable ? 0.3 : 1.0;
        if (!card.isFaceUp) {
            [cardButton setImage:backImage forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }

    }
    self.scoreLabel.text=[NSString stringWithFormat:@"Score: %d", self.game.score];

}
-(void) setFlipsCount:(int)flipsCount
{
    _flipsCount=flipsCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d",self.flipsCount];
    self.gameResult.score=self.game.score;
}
- (IBAction)flipCard:(UIButton *)sender
{
    
    NSString *desc=[self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
  
     self.flipsCount++;
    [self updateUI:desc ];
}

@end
