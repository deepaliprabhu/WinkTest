//
//  BluetoothListener.h
//  WinkAPI
//
//  Created by Aginova Development on 09/05/14.
//  Copyright (c) 2015 - Aginova Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <QuartzCore/QuartzCore.h>
#import "WinkBluetoothProtocol.h"

#define __BLUETOOTH [BluetoothListener sharedInstance]


@interface BluetoothListener : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate> {
    BOOL livePacketsReceived;
    BOOL storedPacketsReceived;
    int batteryLevel;
    int sensorId;
    int productId;
    NSNumber *lastTemp;
    int tempPrecision;
    int tempUnit;
    int storedPacketCount;
    int storedPacketsRead;
    int ledMode;
    long int liveTimestamp;
    BOOL alarmState;
    NSString *firmwareVersion;
    NSString *serialNumber;
    NSMutableString *modeString;
    NSTimeInterval scanInterval;
    NSTimeInterval alarmTime;
    NSTimeInterval deviceUnixTime;
    BluetoothError errorCode;
}

// the delegate, handling the incoming packets
@property (nonatomic, weak) id <WinkBluetoothProtocol> delegate;
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) NSMutableArray     *peripherals;
@property (nonatomic, strong) CBPeripheral     *peripheral;
@property (nonatomic, strong) CBCharacteristic     *tempCharacteristic;
@property (nonatomic, strong) CBCharacteristic     *sfTempCharacteristic;
@property (nonatomic, strong) CBCharacteristic     *batteryCharacteristic;
@property (nonatomic, strong) CBCharacteristic     *modeCharacteristic;
@property (nonatomic, strong) CBCharacteristic     *deviceTimeCharacteristic;
@property (nonatomic, strong) NSTimer *dataTimer;

+ (BluetoothListener *)sharedInstance;

//initialise listener
- (void) initialiseBluetooth:(NSTimeInterval)interval;

// unpair/reset values in singleton to empty state...
- (void) resetBluetooth;

//scan for availabledevices
- (void) startScanning:(NSTimeInterval)interval;
- (void) stopScanning;

// Starts listening for incoming packets
- (void) startListening;
- (void) stopListening;

- (void) restoreCentralWithIdentifier:(NSString*)identifier;
- (void) connectToBLEDeviceWithIdentifier:(NSString*)identifier;
- (void) disconnectBLEDevice;

//called to sync clock
- (void) syncDeviceClock;


//returns connected device state
- (DeviceState) checkConnectionForDeviceWithIdentifier:(NSString*)identifier;

- (void) setLEDState:(BOOL)mode;//True:LED on, False:LED off
- (BOOL) getLEDState;
- (void) setTemperaturePrecision:(NSNumber*)value;//0:0.01°, 1:0.1°
- (NSNumber*) getTemperaturePrecision;
- (void) setTemperatureUnit:(NSNumber*)value;//0:°C, 1:°F
- (NSNumber*) getTemperatureUnit;
- (void) setAlarmTime:(NSTimeInterval)alarmTime_;
- (NSTimeInterval) getAlarmTime;
- (void) disableAlarm;
- (BOOL) getAlarmState;


- (NSNumber*) getBatteryLevel;
- (NSString*) getFirmwareVersion;
- (NSString*) getSerialNumber;
- (NSNumber*) getRSSI;
- (NSNumber*) getPacketCount;

@end
