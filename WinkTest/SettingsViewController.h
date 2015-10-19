//
//  SettingsViewController.h
//  WinkTest
//
//  Created by Deepali Prabhu on 25/06/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinkAPIHandler.h"
#import "SBFlatDatePicker.h"

@interface SettingsViewController : UIViewController <APIHandlerProtocol, UIPickerViewDelegate, SBFLatDatePickerDelegate> {
    IBOutlet UISwitch *_ledSwitch;
    IBOutlet UISwitch *_alarmSwitch;
    IBOutlet UILabel *_timeLabel;
    IBOutlet UIButton *_setTimeButton;
    IBOutlet UISegmentedControl *_tempUnitControl;
    IBOutlet UISegmentedControl *_tempPrecisionControl;
    IBOutlet UIDatePicker *_timePicker;
}
@end
