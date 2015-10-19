//
//  WinkAPIHandler.h
//  WinkTest
//
//  Created by Deepali Prabhu on 25/06/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WinkAPI/WinkAPI.h>
#import "defines.h"

#define __WinkAPIHandler [WinkAPIHandler sharedInstance]

@protocol APIHandlerProtocol;
@interface WinkAPIHandler : NSObject <WinkBluetoothProtocol>  {
    BOOL ledState;
    id firstDelegate;
}
+ (id) sharedInstance;
__pd(APIHandlerProtocol);
@end

@protocol APIHandlerProtocol <NSObject>
@optional

- (void) bluetoothSensor:(int)sensorID type:(ProductType)type receivedPacket:(WinkData*)data;
- (void) bluetoothPeripherals:(NSMutableArray*)peripherals;
- (void) bluetoothScanFailed:(NSString*)errorMessage;
- (void) didDiscoverPeripheral:(NSString *)peripheralName withIdentifier:(NSString*)identifier;
- (void) didConnectPeripheralWithIdentifier:(NSString*)identifier;
- (void) didRestorePeripheralWithIdentifier:(NSString *)identifier;
- (void) didFailToConnectPeripheral;
- (void) didDisconnectPeripheral;
- (void) didUpdateTemperaturePrecisionWithError:(int)error;
- (void) didReceiveFirmwareVersion:(NSString*)firmwareVersion;
- (void) didReceiveSerialNumber:(NSString*)serialNumber;
- (void) didReceiveRSSI:(NSNumber*)rssi;
- (void) didReceiveBatteryLevel:(NSNumber*)batteryLevel;
- (void) didReceiveStoredPacketCount:(NSNumber*)packetCount;
- (void) didReceiveLEDState:(BOOL)ledState;
- (void) didReceiveTempUnit:(NSNumber*)tempUnit;
- (void) didReceiveTempPrecision:(NSNumber*)tempPrecision;
- (void) bluetoothError:(NSString*)errorMessage;
- (void) didReceiveAlarmTime:(NSTimeInterval)interval;
- (void) didReceiveAlarmState:(BOOL)alarmState;

- (BOOL) getLEDState;
- (void) setAPIDelegate:(id)delegate_;

@end
