// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (readwrite, nonatomic) NSString *label;
@property (readwrite, nonatomic) NSUInteger kMatchGame;

// Should the chosen cards be matched.
@property (nonatomic) BOOL shouldMatchCards;

//The cards that are displayed in the game.
@property (strong, nonatomic) NSMutableArray *cards;

//Currently chosen cards in the game.
@property (strong, nonatomic) NSMutableArray *chosenCards;
@end

//Bonus multiplier for matching \c kMtachGame cards.
static const int kMatchBonus = 4;

//Cost to choose a single card.
static const int kCostToChoose = 1;

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
                    withKMatching:(NSUInteger)kMatch {
  if (self = [super init]) {
    self.cards = [[NSMutableArray alloc] init];
    self.chosenCards = [[NSMutableArray alloc] init];
    for(int i = 0; i < count; i++) {
      Card* randomCard = [deck drawRandomCard];
      if(!randomCard){
        self = nil;
        break;
      }
      [self.cards addObject:randomCard];
    }
    self.kMatchGame = kMatch;
  }
  return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return index <= self.cards.count ?  self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  [self updateChosenCards];
  Card* card = [self cardAtIndex:index];
  if(card.isMatched) {
    return;
  }
  if(card.isChosen) {
    self.label = @"" ;
    card.chosen = NO;
  } else {
    card.chosen = YES;
    if([self onlySingleCardWasChosen]) {
      self.label = [NSString stringWithFormat:@" single card chosen! penalty of %d.", kCostToChoose];
      self.score -= kCostToChoose;
    } else {
      [self updateLabelAndScore:card];
      [self handleChosenCards:card];
    }
    [self.chosenCards addObject:card];
  }
}

- (void)updateLabelAndScore:(Card *)card {
  int matchScore = [card match:self.chosenCards];
  if(matchScore) {
    self.shouldMatchCards = YES;
    matchScore = matchScore * kMatchBonus * (int)self.kMatchGame;
    self.label = [NSString stringWithFormat:@" matched! bonus of %d.", matchScore];
    self.score += matchScore;
  } else {
    self.label = [NSString stringWithFormat:@" dont match! penalty of %lu.", self.kMatchGame];
    self.score -= self.kMatchGame;
  }
}

- (void)handleChosenCards:(Card *)card{
  if(self.chosenCards.count + 1 != self.kMatchGame) {
    card.chosen = YES;
    return;
  }
  for(Card *otherCard in self.chosenCards) {
    otherCard.matched = self.shouldMatchCards;
    otherCard.chosen = self.shouldMatchCards;
  }
  if(self.shouldMatchCards) {
    card.matched = YES;
    card.chosen = YES;
    self.shouldMatchCards = NO;
  }
}

- (BOOL)onlySingleCardWasChosen {
  return self.chosenCards.count == 0;
}

- (void)updateChosenCards {
  [self.chosenCards removeAllObjects];
  for(Card *otherCard in self.cards) {
    if(otherCard.isChosen && !otherCard.isMatched) {
      [self.chosenCards addObject:otherCard];
    }
  }
}

- (NSArray *)getChosenCards {
  return [self.chosenCards copy];
}
@end

NS_ASSUME_NONNULL_END
