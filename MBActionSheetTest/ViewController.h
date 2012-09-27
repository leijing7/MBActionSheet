//
//  ViewController.h
//  MBActionSheetTest
//
//  Created by Lei Jing on 27/09/12.
//  Copyright (c) 2012 com.leijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBActionSheetDelegate.h"

@interface ViewController : UIViewController <MBActionSheetDelegate>
- (IBAction)buttonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end
