// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetGameViewController()
@end

@implementation SetGameViewController

//Number of cards required for a match in set game.
static const int kNumberOfCardsForMatch = 3;

- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *)createGameWith:(NSUInteger)count cardsUsingDeck:(Deck *)deck{
  return [[CardMatchingGame alloc]
          initWithCardCount:count
          usingDeck:deck withKMatching:kNumberOfCardsForMatch];
}

- (NSAttributedString *)getCardContentWithAttributes:(Card *)card {
  return [[NSAttributedString alloc] initWithString:card.contents attributes:card.attributes];
}

- (void)backgroundImageForCard:(UIButton *)cardButton :(Card *)card {
  if(card.isChosen) {
    cardButton.layer.cornerRadius = 20;
    cardButton.layer.borderWidth = 2.0;
    cardButton.layer.masksToBounds = YES;
    cardButton.layer.borderColor = [[UIColor redColor] CGColor];
  } else {
    cardButton.layer.cornerRadius = 0;
    cardButton.layer.borderWidth = 0;
    cardButton.layer.masksToBounds = NO;
    cardButton.layer.borderColor = [[UIColor whiteColor] CGColor];
  }
}

- (void)updateChosenCardUI:(UIButton *)cardButton :(Card *)card {
  [cardButton setAttributedTitle:[self getCardContentWithAttributes:card] forState:UIControlStateNormal];
  [self backgroundImageForCard:cardButton :card];
}

@end

NS_ASSUME_NONNULL_END
