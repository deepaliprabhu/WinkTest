//
//  GenericProduct.h
//  WinkAPI
//
//  Created by Sebastian Gabor on 6/18/13.
//  Copyright (c) 2015 - Aginova Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductProtocol.h"

@interface GenericProduct : NSObject <ProductProtocol>

@property (strong, nonatomic) RangeDefinition* rangeDefinitionM1;

- (id) initWithType:(ProductType)type andName:(NSString*)name;

- (RangeDefinition*) sensorM1Range;

- (NSString*)productName;

- (unsigned int)sensorsCount;
- (unsigned int)numberOfDigits;
- (unsigned int)productNumber;

@end
