// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardGameViewController()
@end

@implementation PlayingCardGameViewController
//Number of cards required for a match in matchismo game
static const int kNumberCardsForMatch = 2;

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)createGameWith:(NSUInteger)count cardsUsingDeck:(Deck *)deck{
  return [[CardMatchingGame alloc]
          initWithCardCount:count
          usingDeck:deck withKMatching:kNumberCardsForMatch];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSAttributedString *)titleForCard:(Card *)card {
  NSString *content = card.isChosen ? card.contents : @"";
  return [[NSMutableAttributedString alloc] initWithString:content attributes:[card attributes]];
}

- (void)updateChosenCardUI:(UIButton *)cardButton :(Card *)card {
  [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
  [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
}


@end

NS_ASSUME_NONNULL_END
