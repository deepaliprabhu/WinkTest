//
//  ProductProtocol.h
//  WinkAPI
//
//  Created by Aginova on 3/22/11.
//  Copyright (c) 2015 - Aginova Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WinkData.h"
#import "RangeDefinition.h"

@protocol ProductProtocol <NSObject>

@required

// The range definition for sensor M1
- (RangeDefinition*) sensorM1Range;

// Number of sensors on this product
- (unsigned int)sensorsCount;

// Number of digits of resolution for this product
- (unsigned int)numberOfDigits;

// Product number
- (unsigned int)productNumber;

// Product name
- (NSString*)productName;


@end
