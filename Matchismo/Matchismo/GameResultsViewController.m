//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 10.2.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "GameResultsViewController.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
//@property (strong,nonatomic) GameResult *gameResult;
@property (strong,nonatomic) NSArray *allGameResults;
@end

@implementation GameResultsViewController
- (IBAction)sortByDate
{
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(dateCompare:)];
    [self updateUI];
}

- (IBAction)sortByScore
{
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(scoreCompare:)];
    [self updateUI];
}

- (IBAction)sortByDuration
{
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(durationCompare:)];
    [self updateUI];
}
-(void) updateUI
{
    NSString *displayText=@"";
    for(GameResult *results in self.allGameResults){
        displayText=[displayText stringByAppendingFormat:@"Score: %d (%@ %0g)\n",results.score,
        [NSDateFormatter localizedStringFromDate:results.end dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle],
        round(results.duration)];
    }
    self.display.text=displayText;
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.allGameResults=[GameResult allGameResults];
    [self updateUI];
}

-(void) setup
{
    //initilazitaion that can't wait viewDidLoad
}

//i ovo nemoj da  zaboravis da dodas
-(void) awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}
@end
