//
//  WinkAPIHandler.m
//  WinkTest
//
//  Created by Deepali Prabhu on 25/06/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import "WinkAPIHandler.h"


static WinkAPIHandler *_sharedInstance = nil;

@implementation WinkAPIHandler

+ (id) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self new];
    });
    
    return _sharedInstance;
}


- (void) didReceiveFirmwareVersion:(NSString*)firmwareVersion {
    [_delegate didReceiveFirmwareVersion:firmwareVersion];
    if (firstDelegate) {
        [firstDelegate didReceiveFirmwareVersion:firmwareVersion];
    }
}

- (void) didReceiveSerialNumber:(NSString*)serialNumber {
    [_delegate didReceiveSerialNumber:serialNumber];
    if (firstDelegate) {
        [firstDelegate didReceiveSerialNumber:serialNumber];
    }
}

- (void) didReceiveRSSI:(NSNumber*)rssi {
    [_delegate didReceiveRSSI:rssi];
    if (firstDelegate) {
        [firstDelegate didReceiveRSSI:rssi];
    }
}

- (void) didReceiveBatteryLevel:(NSNumber*)batteryLevel {
    [_delegate didReceiveBatteryLevel:batteryLevel];
    if (firstDelegate) {
        [firstDelegate didReceiveBatteryLevel:batteryLevel];
    }
}

- (void) didReceiveStoredPacketCount:(NSNumber *)packetCount {
    [_delegate didReceiveStoredPacketCount:packetCount];
    if (firstDelegate) {
        [firstDelegate didReceiveStoredPacketCount:packetCount];
    }
}

- (void) didReceiveLEDState:(BOOL)ledState_ {
    ledState = ledState_;
    [_delegate didReceiveLEDState:ledState_];
    if (firstDelegate) {
        [firstDelegate didReceiveLEDState:ledState_];
    }
}

- (void) didReceiveAlarmState:(BOOL)alarmState_ {
    [_delegate didReceiveAlarmState:alarmState_];
    if (firstDelegate) {
        [firstDelegate didReceiveAlarmState:alarmState_];
    }
}

- (void) didReceiveTempUnit:(NSNumber*)tempUnit {
    //ledState = ledState;
    [_delegate didReceiveTempUnit:tempUnit];
    if (firstDelegate) {
        [firstDelegate didReceiveTempUnit:tempUnit];
    }
}

- (void) didReceiveTempPrecision:(NSNumber*)tempPrecision {
    [_delegate didReceiveTempPrecision:tempPrecision];
    if (firstDelegate) {
        [firstDelegate didReceiveTempPrecision:tempPrecision];
    }
}

- (void) didReceiveAlarmTime:(NSTimeInterval)interval {
    [_delegate didReceiveAlarmTime:interval];
    if (firstDelegate) {
        [firstDelegate didReceiveAlarmTime:interval];
    }
}

- (void) bluetoothSensor:(int)sensorId type:(ProductType)type receivedPacket:(WinkData*)data {
    NSLog(@"ble data recvd sensors id =%d",sensorId);
    if (firstDelegate&&([firstDelegate isEqual:_delegate])) {
        [firstDelegate bluetoothSensor:sensorId type:type receivedPacket:data];
    }
    else {
        [_delegate bluetoothSensor:sensorId type:type receivedPacket:data];
    }
}

- (void) didDiscoverPeripheral:(NSString *)peripheralName withIdentifier:(NSString *)identifier{
    [__WINKAPI connectToDeviceWithIdentifier:identifier];
}

- (void) didConnectPeripheralWithIdentifier:(NSString *)identifier{
    NSLog(@"connected to peripheral");
    if (firstDelegate&&([firstDelegate isEqual:_delegate])) {
        [firstDelegate didConnectPeripheralWithIdentifier:identifier];
    }
    else {
        [_delegate didConnectPeripheralWithIdentifier:identifier];
    }
}

- (void) didRestorePeripheralWithIdentifier:(NSString *)identifier{
    NSLog(@"restored peripheral");
    [__WINKAPI connectToDeviceWithIdentifier:identifier];
}

- (void) didDisconnectPeripheral{
    NSLog(@"disconnected to peripheral");
    if (firstDelegate&&([firstDelegate isEqual:_delegate])) {
        [firstDelegate didDisconnectPeripheral];
    }
    else {
        [_delegate didDisconnectPeripheral];
    }
}

- (void) bluetoothScanFailed:(NSString*)errorMessage {
    if (firstDelegate&&([firstDelegate isEqual:_delegate])) {
        [firstDelegate bluetoothScanFailed:errorMessage];
    }
    else {
        [_delegate bluetoothScanFailed:errorMessage];
    }
}

- (void) bluetoothError:(BluetoothError)errorCode {
    [_delegate bluetoothError:[self getDescriptionForErrorCode:errorCode]];
}

- (NSString*)getDescriptionForErrorCode:(BluetoothError)errorCode {
    switch (errorCode) {
        case BluetoothPowerOff:
            return @"Bluetooth is Off";
            break;
        case BluetoothScanFailed:
            return @"Bluetooth scan failed";
            break;
        case BluetoothStateResetting:
            return @"Bluetooth state is resetting";
            break;
        case BluetoothStateUnauthorized:
            return @"Bluetooth state is unauthorized";
            break;
        case BluetoothStateUnknown:
            return @"Bluetooth state is unknown";
            break;
        case BluetoothUnsupported:
            return @"Bluetooth state is unsupported";
            break;
        default:
            break;
    }
    return nil;
}


- (BOOL) getLEDState {
    return ledState;
}

- (void) setAPIDelegate:(id)delegate_ {
    [self setDelegate:delegate_];
    if (!firstDelegate) {
        firstDelegate = delegate_;
    }
}


@end
