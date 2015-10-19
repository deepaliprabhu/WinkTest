//
//  Data.h
//  WinkAPI
//
//  Created by Aginova on 6/10/11.
//  Copyright (c) 2015 - Aginova Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinkData : NSObject

@property (nonatomic, assign) int sensorId;

// timestamp related to iOS device
@property (nonatomic, assign) NSTimeInterval timestamp;

// temperature value 
@property (nonatomic, strong) NSNumber *temp;

// last temperature value
@property (nonatomic, strong) NSNumber *lastTemp;

// packet type 0:live packet, 1:stored packet Used for test purpose
@property (nonatomic, strong) NSNumber *packetType;

// packet index
@property (nonatomic, strong) NSNumber *packetIndex;

@end
