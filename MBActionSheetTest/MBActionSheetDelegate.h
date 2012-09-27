//
//  MBActionSheetDelegate.h
//  PhotoCrop
//
//  Created by Lei Jing on 25/09/12.
//  Copyright (c) 2012 com.leijing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBActionSheet;

@protocol MBActionSheetDelegate <NSObject>

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)mbactionSheet:(MBActionSheet *)mbactionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
