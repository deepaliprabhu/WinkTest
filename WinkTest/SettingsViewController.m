//
//  SettingsViewController.m
//  WinkTest
//
//  Created by Deepali Prabhu on 25/06/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [__WinkAPIHandler setDelegate:self];
    // Do any additional setup after loading the view from its nib.
    [_ledSwitch setOn:[__WINKAPI getLEDState]];
    [_alarmSwitch setOn:[__WINKAPI getAlarmState]];
    [_tempUnitControl setSelectedSegmentIndex:[[__WINKAPI getTemperatureUnit] integerValue]];
    [_tempPrecisionControl setSelectedSegmentIndex:[[__WINKAPI getTemperaturePrecision] integerValue]];
    //[_timePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[__WINKAPI getAlarmTime]] animated:true];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:[__WINKAPI getAlarmTime]]];
    _timeLabel.text = dateString;
}

- (void)viewDidAppear:(BOOL)animated {
    [__WinkAPIHandler setDelegate:self];
    [_ledSwitch setOn:[__WINKAPI getLEDState]];
    [_tempUnitControl setSelectedSegmentIndex:[[__WINKAPI getTemperatureUnit] integerValue]];
    [_tempPrecisionControl setSelectedSegmentIndex:[[__WINKAPI getTemperaturePrecision] integerValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //ViewController *controller = (ViewController*)[storyboard instantiateInitialViewController];
    //[self presentViewController:controller animated:YES completion:nil];
    //[controller startProcess];
    //[self removeFromParentViewController ];
    [self.navigationController popViewControllerAnimated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) didReceiveFirmwareVersion:(NSString*)firmwareVersion {
}

- (void) didReceiveSerialNumber:(NSString*)serialNumber {
}

- (void) didReceiveRSSI:(NSNumber*)rssi {
}

- (void) didReceiveBatteryLevel:(NSNumber*)batteryLevel {
}

- (void) didReceiveStoredPacketCount:(NSNumber *)packetCount {
}

- (void) didReceiveLEDState:(BOOL)ledState {
    [_ledSwitch setOn:ledState animated:true];
}

- (void) didReceiveAlarmState:(BOOL)alarmState_ {
    [_alarmSwitch setOn:alarmState_ animated:true];
}

- (void) didReceivePairedState:(BOOL)pairedState_ {
    if (!pairedState_) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"\n" message:@"Please set wink in pairing mode and connect again" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void) didReceiveTempUnit:(NSNumber*)tempUnit {
    [_tempUnitControl setSelectedSegmentIndex:[tempUnit integerValue]];
}

- (void) didReceiveTempPrecision:(NSNumber*)tempPrecision {
    [_tempPrecisionControl setSelectedSegmentIndex:[tempPrecision integerValue]];
}

- (void) didReceiveAlarmTime:(NSTimeInterval)interval {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:interval]];
    _timeLabel.text = dateString;
}

- (void) bluetoothSensor:(int)sensorId type:(ProductType)type receivedPacket:(WinkData*)data {
    NSLog(@"ble data recvd sensors id =%d",sensorId);

}

- (void) didDiscoverPeripheral:(NSString *)peripheralName withIdentifier:(NSString *)identifier{
    [__WINKAPI connectToDeviceWithIdentifier:identifier];
}

- (void) didConnectPeripheralWithIdentifier:(NSString *)identifier{
}

- (void) didRestorePeripheralWithIdentifier:(NSString *)identifier{
    NSLog(@"restored peripheral");
}

- (void) didDisconnectPeripheral{
}

- (void) bluetoothScanFailed:(NSString*)errorMessage {

}

- (IBAction)switchPressed:(id)sender {
    [__WINKAPI setLEDState:_ledSwitch.on];
}

- (IBAction)alarmSwitchPressed:(id)sender {
    if (_alarmSwitch.on) {
        _setTimeButton.hidden = false;
    }
    else {
        _setTimeButton.hidden = true;
        [__WINKAPI disableAlarm];
    }
}

- (IBAction)tempUnitControlPressed {
    NSLog(@"temp unit pressed");
    [__WINKAPI setTemperatureUnit:[NSNumber numberWithInteger:_tempUnitControl.selectedSegmentIndex]];
}

- (IBAction)tempPrecisionControlPressed {
    NSLog(@"temp precision pressed");
    [__WINKAPI setTemperaturePrecision:[NSNumber numberWithInteger:_tempPrecisionControl.selectedSegmentIndex]];
}

- (IBAction)setAlarmTimePressed:(id)sender {
   // NSDate *pickerDate = [_timePicker date];
   // NSTimeInterval interval = [pickerDate timeIntervalSince1970];
   // [__WINKAPI setAlarmTime:interval];
    [self showDatePickerWithTag:0];
}

- (IBAction)killButtonPressed {
    kill(getpid(), SIGKILL);
}

- (void) bluetoothError:(NSString*)errorMessage {
}

- (void)showDatePickerWithTag:(int)tag_ {
    NSLog(@"showing date picker");
    
    //Init the datePicker view and set self as delegate
    SBFlatDatePicker *datePicker = [[SBFlatDatePicker alloc] initWithFrame:self.view.bounds];
    [datePicker setDelegate:self];
    datePicker.tag = tag_;
    
    //OPTIONAL: Choose the background color
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    
    //OPTIONAL - Choose Date Range (0 starts At Today. Non continous sets acceptable (use some enumartion for [indexSet addIndex:yourIndex];
    datePicker.dayRange = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 365)];
    
    
    //OPTIONAL - Choose Minute  Non continous sets acceptable (use some enumartion for [indexSet addIndex:yourIndex];
    datePicker.minuterange = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 59)];
    
    //Customize date format
    datePicker.dayFormat = @"EEE MMM dd";
    
    
    //Set the data picker as view of the new view controller
    [self.view addSubview:datePicker];
    
    //Present the view controller
    //[self presentViewController:pickerViewController animated:YES completion:nil];
}

//Delegate
-(void)flatDatePicker:(SBFlatDatePicker *)datePicker saveDate:(NSDate *)date{
    NSLog(@"%@",[date description]);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:date];
    NSTimeInterval interval = [date timeIntervalSince1970];
    [__WINKAPI setAlarmTime:interval];

}

@end
