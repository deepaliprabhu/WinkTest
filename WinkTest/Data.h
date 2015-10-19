//
//  Data.h
//  WinkTest
//
//  Created by Deepali Prabhu on 29/06/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WinkAPI/WinkAPI.h>

@interface Data : NSObject {
    float temp;
    NSString *timestamp;
    NSMutableArray *tempArray;
    
}

- (void)receivedPacket:(WinkData*)data;

@end
