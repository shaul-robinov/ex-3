// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCard

- (int)match:(NSArray *)otherCards {
  if(![self verifyCardsElligibleForMatch:otherCards]){
    return 0;
  }
  for(NSString *property in [self getSetCardProperties]) {
    if(![self singleMatchOf:otherCards WithProperty:property]) {
      return 0;
    }
  }
  return 3;
}

- (NSString *)contents {
  NSInteger numberOfShapes = [self.number integerValue];
  NSString* nonAttributedString = [@""
    stringByPaddingToLength: numberOfShapes
    withString:self.symbol
    startingAtIndex:0];
  return nonAttributedString;
}


- (NSDictionary *)attributes {
  float shadeValue = [self.shading floatValue];
  UIColor *transparentColor = [self.color colorWithAlphaComponent:shadeValue];
  return @{
    NSStrokeWidthAttributeName : @(-5),
    NSStrokeColorAttributeName : self.color,
    NSForegroundColorAttributeName: transparentColor,
    NSFontAttributeName: [UIFont fontWithName:@"GillSans-Light" size:17.0f]
    };
}

- (BOOL)singleMatchOf:(NSArray *)otherCards WithProperty:(NSString *)property {
  BOOL allEqual, allDifferent;
  id firstVal = [self valueForKey:property];
  id secondVal = [otherCards[0] valueForKey:property];
  id thirdVal = [otherCards[1] valueForKey:property];
  
  allEqual = (firstVal == secondVal) && (firstVal == thirdVal);
  allDifferent = (firstVal != secondVal) && (secondVal != thirdVal) &&
    (thirdVal != firstVal);
  return allEqual || allDifferent;
  
}

- (BOOL)verifyCardsElligibleForMatch:(NSArray *)otherCards {
  if(otherCards.count != 2) {
    return NO;
  }
  for(id card in otherCards) {
    if(![card isKindOfClass:[SetCard class]]) {
      return NO;
    }
  }
  return YES;
}

- (NSArray<NSString *> *)getSetCardProperties {
  return @[
           @"shading",
           @"number",
           @"symbol",
           @"color"
           ];
}

+ (NSArray<NSString *> *)validSymbols {
  return @[
           @"▲",
           @"●",
           @"■"
           ];
}

+ (NSArray<UIColor *> *)validColors {
  return @[
           UIColor.purpleColor,
           UIColor.redColor,
           UIColor.greenColor
           ];
}

+ (NSArray<NSNumber *> *)validShadings {
  return @[
           @0.0,
           @0.3,
           @1.0
           ];
}

+ (NSArray<NSNumber *> *)validNumberOfSymbols {
  return @[
           @1,
           @2,
           @3
           ];
}
@end

NS_ASSUME_NONNULL_END
