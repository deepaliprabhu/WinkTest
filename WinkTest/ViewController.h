//
//  ViewController.h
//  WinkTest
//
//  Created by Aginova on 15/04/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinkAPIHandler.h"


@interface ViewController : UIViewController<APIHandlerProtocol > {
    IBOutlet UILabel *_messageLabel;
    IBOutlet UILabel *_liveTempLabel;
    IBOutlet UILabel *_packetCountLabel;
    IBOutlet UILabel *_storedTempLabel;
    IBOutlet UILabel *_liveTimestampLabel;
    IBOutlet UILabel *_deviceTimeLabel;
    IBOutlet UILabel *_storedTimestampLabel;
    IBOutlet UILabel *_firmwareRevLabel;
    IBOutlet UILabel *_serialNumberLabel;
    IBOutlet UILabel *_batteryLevelLabel;
    IBOutlet UILabel *_rssiLevelLabel;
    IBOutlet UIButton *_startButton;
    IBOutlet UIButton *_settingsButton;
    IBOutlet UIButton *_connectButton;
    IBOutlet UIScrollView *_scrollView;
    NSMutableArray *bleDevices;
    NSString *peripheral;
    int recvdPacketCount;
    int storedPacketCount;
    NSString *deviceIdentifier;
    BOOL connected;

}
- (void)startProcess;

@end

