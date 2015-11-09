//
//  ViewController.m
//  WinkTest
//
//  Created by Aginova on 15/04/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    [self startProcess];
    [__WinkAPIHandler setAPIDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear called");
    [__WinkAPIHandler setAPIDelegate:self];
    /*if (deviceIdentifier) {
        DeviceState state = [__WINKAPI checkConnectionForDeviceWithIdentifier:deviceIdentifier];
        switch (state) {
            case 0:{
                _messageLabel.text = @"Device Disconnected";
                //[__WINKAPI connectToDeviceWithIdentifier:deviceIdentifier];
            }
                break;
            case 1:
                _messageLabel.text = @"Device connecting";
                break;
            case 2:
                _messageLabel.text = @"Device connected";
                break;
            default:
                break;
        }
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonTapped:(id)sender {
    _startButton.enabled = false;
    _messageLabel.text = @"Scanning for devices...";
}

- (void)startProcess {
    _startButton.enabled = false;
    _messageLabel.text = @"Scanning for devices...";
}

- (IBAction)settingsButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = (UIViewController*)[storyboard instantiateViewControllerWithIdentifier:@"settings"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)rescanButtonTapped:(id)sender {
    [__WINKAPI scanBluetoothDevices:10];
}

- (IBAction)disconnectButtonTapped:(id)sender {
    if (connected) {
        _messageLabel.text = @"Disconnecting Device...";
        [__WINKAPI resetBluetooth];
    }
    else {
        _messageLabel.text = @"Connecting Device...";
        [__WINKAPI scanBluetoothDevices:10];
    }
}

#pragma mark - Bluetooth

- (void) didReceiveFirmwareVersion:(NSString*)firmwareVersion {
    _firmwareRevLabel.text = firmwareVersion;
}

- (void) didReceiveSerialNumber:(NSString*)serialNumber {
    _serialNumberLabel.text = serialNumber;
}

- (void) didReceiveRSSI:(NSNumber*)rssi {
    _rssiLevelLabel.text = [rssi stringValue];
}

- (void) didReceiveBatteryLevel:(NSNumber*)batteryLevel {
    _batteryLevelLabel.text = [batteryLevel stringValue];
}

- (void) didReceiveLEDState:(BOOL)ledState {
}

- (void) didReceiveAlarmState:(BOOL)alarmState_ {
}

- (void) didReceiveTempUnit:(NSNumber*)tempUnit {
}

- (void) didReceiveTempPrecision:(NSNumber*)tempPrecision {
}

- (void) didReceiveAlarmTime:(NSTimeInterval)interval {
}

- (void) didReceivePairedState:(BOOL)pairedState_ {
    if (!pairedState_) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"\n" message:@"Please set wink in pairing mode and connect again" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void) didReceiveStoredPacketCount:(NSNumber *)packetCount {
    storedPacketCount = [packetCount intValue];
    _packetCountLabel.text = [NSString stringWithFormat:@"%d",storedPacketCount];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, 20+(storedPacketCount*200))];
}

- (void) bluetoothSensor:(int)sensorId type:(ProductType)type receivedPacket:(WinkData*)data {
    NSLog(@"ble data recvd sensors id =%d",sensorId);
    if (data == nil) {
        
    }
    else {
        if ([data.packetType intValue] == 1) {
            _liveTempLabel.text = [NSString stringWithFormat:@"%f",[data.temp floatValue]];
            UIView * storedPacketView = [[UIView alloc] init];
            storedPacketView.frame = CGRectMake(0, recvdPacketCount*100+10, _scrollView.frame.size.width, 160);
            [_scrollView addSubview:storedPacketView];
            UILabel *storedTempLabel = [[UILabel alloc] init];
            storedTempLabel.text = [NSString stringWithFormat:@"Stored Temp %d: %f",recvdPacketCount+1,[data.temp floatValue]];
            storedTempLabel.frame = CGRectMake(10, 10, storedPacketView.frame.size.width, 50);
            storedTempLabel.font = [UIFont systemFontOfSize:14.0];
            [storedPacketView addSubview:storedTempLabel];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:data.timestamp];
            NSString *formattedDateString = [dateFormatter stringFromDate:date];
            NSLog(@"formattedDateString: %@", formattedDateString);
            UILabel *storedTimestampLabel = [[UILabel alloc] init];
            storedTimestampLabel.text = [NSString stringWithFormat:@"Stored Time: %@",formattedDateString];
            storedTimestampLabel.frame = CGRectMake(10, 40, storedPacketView.frame.size.width, 50);
            storedTimestampLabel.font = [UIFont systemFontOfSize:14.0];
            [storedPacketView addSubview:storedTimestampLabel];
            recvdPacketCount++;
            if (recvdPacketCount== storedPacketCount) {
               // _deviceTimeLabel.text = formattedDateString;
                //_liveTimestampLabel.text = [NSString stringWithFormat:@"%ld",[data.sensorTimestamp longValue]];
                _liveTempLabel.text = [NSString stringWithFormat:@"%f",[data.temp floatValue]];

            }
        }
        else {
           // _packetCountLabel.text = [NSString stringWithFormat:@"%d",[data.storedPacketCount intValue]];
           // [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, 20+([data.storedPacketCount intValue]*200))];
            //_liveTempLabel.text = [NSString stringWithFormat:@"%f",[data.temp floatValue]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:data.timestamp];
            NSString *formattedDateString = [dateFormatter stringFromDate:date];
            NSLog(@"formattedDateString: %@", formattedDateString);
            _deviceTimeLabel.text = formattedDateString;
        }
    }
}

- (void) didDiscoverPeripheral:(NSString *)peripheralName withIdentifier:(NSString *)identifier{
    peripheral = peripheralName;
    [__WINKAPI connectToDeviceWithIdentifier:identifier];
}

- (void) didConnectPeripheralWithIdentifier:(NSString *)identifier{
    _messageLabel.text = [NSString stringWithFormat:@"Connected to peripheral: %@ with Identifier:%@",peripheral, identifier];
    deviceIdentifier = identifier;
    _settingsButton.enabled = true;
    DeviceState state = [__WINKAPI checkConnectionForDeviceWithIdentifier:deviceIdentifier];
    NSLog(@"device state = %d",state);
    connected = true;
    [_connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
}

- (void) didRestorePeripheralWithIdentifier:(NSString *)identifier{
    _messageLabel.text = [NSString stringWithFormat:@"Connected to peripheral: %@ with Identifier:%@",peripheral, identifier];
    deviceIdentifier = identifier;
}

- (void) didDisconnectPeripheral{
    _messageLabel.text = @"Device Disconnected";
    connected = false;
    [_connectButton setTitle:@"Connect" forState:UIControlStateNormal];
}

- (void) bluetoothError:(NSString*)errorMessage {
    _messageLabel.text = errorMessage;
}



@end
