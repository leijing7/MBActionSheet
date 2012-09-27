//
//  MBActionSheet.h
//  PhotoCrop
//
//  Created by Lei Jing on 21/09/12.
//  Copyright (c) 2012 com.leijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBActionSheetDelegate.h"

@interface MBActionSheet : UIView
{
    NSString *actionSheetTitle;
    NSString *cancelButtonTitle;
    NSString *destructiveButtonTitle;
    NSArray *otherButtonTitles;
    CGFloat viewHeight;
    
    NSInteger buttonCount;
    NSInteger lineCount; //the line count on the sheet except cancel and destructive
    NSArray *eachLineButtonCount;
    
    UIView *parentView;
    UIView *fullScreenView;
    UIView *sheetView;
    
    CGFloat sheetViewWidth;
    CGFloat sheetViewHeight;
}

@property (nonatomic) NSInteger tag;
@property (nonatomic, weak) id <MBActionSheetDelegate> delegate;

-(id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(id)firstBtnTitle,...;

- (void)setLineCount:(NSInteger)count eachLineButtonCount:(NSArray *)counts;

- (void)showInView:(UIView *)superView;

@end
