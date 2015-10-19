//
//  RangeDefinition.h
//  WinkAPI
//
//  Created by Reshad Moussa on 20.03.12.
//  Copyright (c) 2015 - Aginova Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RangeDefinition : NSObject

// The upper limit for measurement
@property (strong,nonatomic) NSNumber* upperLimit;

// The upper limit to display in Dial in °C
@property (strong,nonatomic) NSNumber* upperLimitDialC;

// The upper limit to display in Dial in °F
@property (strong,nonatomic) NSNumber* upperLimitDialF;

// The lower limit for measurement
@property (strong,nonatomic) NSNumber* lowerLimit;

// The lower limit to display in Dial in °C
@property (strong,nonatomic) NSNumber* lowerLimitDialC;

// The lower limit to display in Dial in °F
@property (strong,nonatomic) NSNumber* lowerLimitDialF;

@end
