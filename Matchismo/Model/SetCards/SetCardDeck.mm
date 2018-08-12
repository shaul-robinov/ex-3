// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import "SetCardDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardDeck
- (instancetype)init {
  if (self = [super init]) {
    for(NSString* symbol in [SetCard validSymbols]) {
      for(UIColor *color in [SetCard validColors]) {
        for(NSNumber *shadeValue in [SetCard validShadings]) {
          for(NSNumber *numberOfSymbols in [SetCard validNumberOfSymbols]) {
            SetCard* newCard = [[SetCard alloc] init];
            newCard.symbol = symbol;
            newCard.color = color;
            newCard.shading = shadeValue;
            newCard.number = numberOfSymbols;
            [self addCard:newCard];
          }
        }
      }
    }
  }  
  return self;
}

@end

NS_ASSUME_NONNULL_END
