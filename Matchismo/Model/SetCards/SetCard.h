// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.
#import "Card.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// A set game card object.
@interface SetCard : Card

/// Valid symbols the cards can have.
+ (NSArray<NSString *> *)validSymbols;

/// Valid colors for the cards.
+ (NSArray<UIColor *> *)validColors;

/// Valid shades for the cards.
+ (NSArray<NSNumber *> *)validShadings;

/// Valid number of symbols the cards can have.
+ (NSArray<NSNumber *> *)validNumberOfSymbols;

/// Card's title properties
@property (strong, nonatomic)UIColor *color;
@property (strong, nonatomic)NSString *symbol;
@property (strong, nonatomic)NSNumber *shading;
@property (nonatomic) NSNumber *number;

@end

NS_ASSUME_NONNULL_END
