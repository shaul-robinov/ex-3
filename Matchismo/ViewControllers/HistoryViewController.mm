// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import "HistoryViewController.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController()
//UI text view displays history of moves in the game
@property (weak, nonatomic) IBOutlet UITextView *historyLabel;

//Array holds the history of the game.
@property (strong, nonatomic) NSMutableAttributedString *history;

@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)updateUI {
  self.historyLabel.attributedText = self.history;
}

- (void)updateHistoy:(NSAttributedString *)history {
  if(!self.history) {
    self.history = [[NSMutableAttributedString alloc] initWithString:@""];
  }
  [self.history appendAttributedString:history];
  [self updateUI];
}

@end

NS_ASSUME_NONNULL_END
