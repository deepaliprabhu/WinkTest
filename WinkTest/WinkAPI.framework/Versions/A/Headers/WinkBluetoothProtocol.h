//
//  BluetoothProtocol.h
//  WinkAPI
//
//  Created by Aginova Development on 09/05/14.
//  Copyright (c) 2015 - Aginova Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WinkAPI.h"

typedef NS_ENUM(NSInteger, BluetoothError)  {
    BluetoothPowerOff = 0,
    BluetoothScanFailed,
    BluetoothScanFoundNoPeripherals,
    BluetoothUnsupported,
    BluetoothStateUnknown,
    BluetoothStateResetting,
    BluetoothStateUnauthorized
};


@protocol WinkBluetoothProtocol <NSObject>

@required

// Call-back when bluetooth data receives a new packet
- (void) bluetoothSensor:(int)sensorID type:(ProductType)type receivedPacket:(WinkData*)data;
- (void) bluetoothError:(BluetoothError)errorCode;
- (void) didDiscoverPeripheral:(NSString *)peripheralName withIdentifier:(NSString*)identifier;
- (void) didRestorePeripheralWithIdentifier:(NSString*)identifier;
- (void) didConnectPeripheralWithIdentifier:(NSString*)identifier;
- (void) didFailToConnectPeripheral;
- (void) didDisconnectPeripheral;

@optional
- (void) bluetoothPeripherals:(NSMutableArray*)peripherals;
- (void) didUpdateTemperaturePrecisionWithError:(int)error;
- (void) didReceiveFirmwareVersion:(NSString*)firmwareVersion;
- (void) didReceiveSerialNumber:(NSString*)serialNumber;
- (void) didReceiveRSSI:(NSNumber*)rssi;
- (void) didReceiveBatteryLevel:(NSNumber*)batteryLevel;
- (void) didReceiveStoredPacketCount:(NSNumber*)packetCount;
- (void) didReceiveLEDState:(BOOL)ledState;
- (void) didReceiveTempUnit:(NSNumber*)tempUnit;
- (void) didReceiveTempPrecision:(NSNumber*)tempPrecision;
- (void) didReceiveAlarmTime:(NSTimeInterval)interval;
- (void) didReceiveAlarmState:(BOOL)alarmState;

@end
