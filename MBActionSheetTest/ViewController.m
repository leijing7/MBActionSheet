//
//  ViewController.m
//  MBActionSheetTest
//
//  Created by Lei Jing on 27/09/12.
//  Copyright (c) 2012 com.leijing. All rights reserved.
//

#import "ViewController.h"
#import "MBActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    
    MBActionSheet *mbas = [[MBActionSheet alloc] initWithTitle:@"test title" delegate:(id)self cancelButtonTitle:@"cancel btn" destructiveButtonTitle:@"destructive" otherButtonTitles:
                           @"1:1", @"3:2",@"4:3",
                           @"2:3", @"3:4", @"16:9",nil];
    
    [mbas setLineCount:2 eachLineButtonCount:[NSArray arrayWithObjects:@3,@3, nil]];
    [mbas setTag:1];
    [mbas showInView:self.view];
    
}

- (void)mbactionSheet:(MBActionSheet *)mbactionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"mbaction sheet tag.%d", mbactionSheet.tag);
    NSLog(@"mbaction sheet button index.%d", buttonIndex);
    
    NSString *labelStr = [NSString stringWithFormat:@"tag: %d, button index: %d", mbactionSheet.tag, buttonIndex];
    [self.displayLabel setText:labelStr];
}
@end
