//
//  WinkAPI.h
//  WinkAPI
//
//  Created by Reshad Moussa on 12.10.11.
//  Copyright (c) 2015 - Aginova Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WinkPublic.h"

typedef NS_ENUM(NSInteger, DeviceState)  {
    DeviceStateDisconnected = 0,
    DeviceStateConnecting,
    DeviceStateConnected
};

#define __WINKAPI       [WinkAPI sharedInstance]


@interface WinkAPI : NSObject

@property (nonatomic, weak) id <ProductProtocol> currentProduct;

@property (nonatomic, weak) id <WinkBluetoothProtocol> bluetoothDelegate;

+ (id) productForType:(ProductType)type;

// The singleton instance
+ (WinkAPI *)sharedInstance;

//Bluetooth communication
- (void) resetBluetooth;
- (void) startBluetoothListening:(int)interval;
- (void) scanBluetoothDevices:(int)interval;
- (void) stopBluetoothScanning;
- (void) stopBluetoothListening;
- (void) startListeningForBLEDevice;
- (void) stopListeningForBLEDevice;
- (void) connectToDeviceWithIdentifier:(NSString*)identifier;
- (void) disconnectBLEDeviceWithIdentifier:(NSString*)identifier;
- (void) restoreCentralWithIdentifier:(NSString*)identifier;
- (void) syncDeviceClock;

/*returns connected device state
 DeviceStateDisconnected = 0,
 DeviceStateConnecting,
 DeviceStateConnected,*/
- (DeviceState) checkConnectionForDeviceWithIdentifier:(NSString*)identifier;

- (void)setLEDState:(BOOL)mode;//True:LED on, False:LED off
- (BOOL) getLEDState;
- (void) setTemperaturePrecision:(NSNumber*)value;//0:0.01°, 1:0.1°
- (NSNumber*) getTemperaturePrecision;
- (void) setTemperatureUnit:(NSNumber*)value;//0:°C, 1:°F
- (NSNumber*) getTemperatureUnit;
- (void) setAlarmTime:(NSTimeInterval)alarmTime_;
- (NSTimeInterval) getAlarmTime;
- (void) disableAlarm;
- (BOOL) getAlarmState;

- (void) getBatteryLevelFromDevice;
- (NSNumber*) getBatteryLevel;
- (NSString*) getFirmwareVersion;
- (NSString*) getSerialNumber;
- (NSNumber*) getRSSI;
- (NSNumber*) getPacketCount;

@end
