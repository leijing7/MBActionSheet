//
//  MBActionSheet.m
//  PhotoCrop
//
//  Created by Lei Jing on 21/09/12.
//  Copyright (c) 2012 com.leijing. All rights reserved.
//

#define ANIMATION_DURATION 0.3f
#define TRANSLUNCENT_RATIO 0.6f

#define BUTTON_HEIGHT 44     //each button height on the sheet view
#define BUTTON_SIDE_OFFSET 35   //the distance from left-most/right-most button to the screen side 
#define BUTTON_HORIZONTAL_OFFSET 28  // the distance between buttons on horizontal
#define BUTTON_VERTICAL_SPACE 10   //the distance between buttons on vertical 

#import "MBActionSheet.h"

#pragma -
#pragma mark internal methods

@interface MBActionSheet (internal_methods)

- (void)putButtonTitleListIntoArray:(va_list)btnList firstTitle:(NSString *)fTitle;

@end

#pragma -
#pragma mark sheetView methods

@interface MBActionSheet (sheetView_methods)

- (void)calcViewHeight;
- (void)addControls;
- (void)addSheetTitleLabel;
- (void)addDestructiveButton;
- (void)addOtherButtons;
- (void)addCancelButton;
- (void)createButton:(CGRect)frm buttonTitile:(NSString *)title buttonIndex:(NSInteger)index;
- (void)calcButtonCount;
- (void)dissmissActionSheet;
- (IBAction)buttonClicked:(UIButton *)sender;

@end

@implementation MBActionSheet

-(id)initWithTitle:(NSString *)sheetTitle delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelBtnTitle destructiveButtonTitle:(NSString *)destructiveBtnTitle otherButtonTitles:(NSString *)firstBtnTitle,...
{   
    actionSheetTitle = sheetTitle;
    self.delegate = (id)delegate;
    cancelButtonTitle = cancelBtnTitle;
    destructiveButtonTitle = destructiveBtnTitle;
    
    va_list otherButtonTitleList;
    va_start(otherButtonTitleList, firstBtnTitle);
    [self putButtonTitleListIntoArray:otherButtonTitleList firstTitle:firstBtnTitle];
    

    return self;
}

- (void)setLineCount:(NSInteger)count eachLineButtonCount:(NSArray *)counts
{
    lineCount = count;
    eachLineButtonCount = counts;
}

- (void)showInView:(UIView *)superView
{
    parentView = superView;
    CGRect fullScreenFrame = [[UIScreen mainScreen] bounds];
    fullScreenView = [[UIView alloc] initWithFrame:fullScreenFrame];
    fullScreenView.backgroundColor = [UIColor colorWithWhite:0 alpha:0]; //0 is totally transparent
    [((UIViewController*)self.delegate).navigationController.navigationBar setUserInteractionEnabled:NO];
    ((UIViewController*)self.delegate).navigationController.navigationBar.alpha = 1.0f; //1.0 is totally transparent
    [superView addSubview:fullScreenView];
    
    sheetViewWidth = superView.frame.size.width;
    [self calcViewHeight];
    sheetViewHeight = viewHeight;
    //hidden from the bottom of the device 
    CGRect viewFrame = CGRectMake(0, superView.frame.size.height, sheetViewWidth, sheetViewHeight);
    sheetView = [self initWithFrame:viewFrame];
    [self addControls];

    [fullScreenView addSubview:sheetView];
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^(void){
        sheetView.center = CGPointMake(sheetViewWidth/2, superView.frame.size.height-sheetViewHeight/2);
        fullScreenView.backgroundColor = [UIColor colorWithWhite:0 alpha:TRANSLUNCENT_RATIO];  
        ((UIViewController*)self.delegate).navigationController.navigationBar.alpha = 1.0f - TRANSLUNCENT_RATIO; 
    }];
}

@end

#pragma mark -
#pragma mark internal methods

@implementation MBActionSheet (internal_methods)

- (void)putButtonTitleListIntoArray:(va_list)btnList firstTitle:(NSString *)fTitle;
{
    NSMutableArray *btnTitles = [[NSMutableArray alloc] init];
    NSString *btnTitle = fTitle;
    while(btnTitle)
    {
        [btnTitles addObject:btnTitle];
        btnTitle = va_arg(btnList, NSString*);
        if(!btnTitle) break; // 'nil' as a list terminator
    }
    va_end(btnList);
    otherButtonTitles = btnTitles;
}

@end

#pragma mark -
#pragma mark sheetView methods

@implementation MBActionSheet (sheetView_methods)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:TRANSLUNCENT_RATIO];
    }
    return self;
}

- (void)calcViewHeight
{
    NSInteger buttonLineCount = 0; //the line number on the sheet
    if (actionSheetTitle) {
        buttonLineCount++;
    }
    if (cancelButtonTitle) {
        buttonLineCount++;
    }
    if (destructiveButtonTitle) {
        buttonLineCount++;
    }
    if (otherButtonTitles.count != 0) {
        buttonLineCount += lineCount;
    }
    viewHeight = buttonLineCount*BUTTON_HEIGHT + (buttonLineCount-1)*BUTTON_VERTICAL_SPACE;
}

- (void)addControls
{
    [self calcButtonCount];
    
    if (actionSheetTitle) {
        [self addSheetTitleLabel];
    }
    if (destructiveButtonTitle) {
        [self addDestructiveButton];
    }
    if (cancelButtonTitle) {
        [self addCancelButton];
    }
    if (otherButtonTitles.count != 0) {
        [self addOtherButtons];
    }
}

- (void)addSheetTitleLabel
{
    CGRect labelFrame = CGRectMake(0.0f, 0.0f, sheetView.frame.size.width, BUTTON_HEIGHT);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    //titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
    titleLabel.text = actionSheetTitle;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.center = CGPointMake(sheetView.center.x, titleLabel.frame.size.height/2);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [sheetView addSubview:titleLabel];
    
}

- (void)addDestructiveButton
{
    CGRect btnFrame = CGRectMake(BUTTON_SIDE_OFFSET, BUTTON_HEIGHT, sheetView.frame.size.width - BUTTON_SIDE_OFFSET*2, BUTTON_HEIGHT);
    [self createButton:btnFrame buttonTitile:destructiveButtonTitle buttonIndex:0];
}

- (void)addOtherButtons
{
    CGFloat startY = 0;
    NSInteger btnIndex = 0;
    if (actionSheetTitle) {
        startY += BUTTON_HEIGHT;
    }
    if (destructiveButtonTitle) {
        startY += BUTTON_HEIGHT + BUTTON_VERTICAL_SPACE;
        btnIndex++;
    }
    
    NSInteger otherBtnCount = 0;
    for (int i=0; i<lineCount; i++) {  //row or line
        startY += (BUTTON_HEIGHT + BUTTON_VERTICAL_SPACE) * i;
        NSInteger currentLineBtnCount = [eachLineButtonCount[i] integerValue];
        NSInteger otherBtnWidth = (self.frame.size.width - BUTTON_SIDE_OFFSET*2 - (currentLineBtnCount- 1)*BUTTON_HORIZONTAL_OFFSET) / currentLineBtnCount;
        
        for (int j=0; j<currentLineBtnCount; j++) {  //colum
            CGRect btnFrame = CGRectMake(BUTTON_SIDE_OFFSET + (otherBtnWidth + BUTTON_HORIZONTAL_OFFSET)*j,
                                         startY,
                                         otherBtnWidth,
                                         BUTTON_HEIGHT);
            [self createButton:btnFrame buttonTitile:otherButtonTitles[otherBtnCount] buttonIndex:btnIndex];
            btnIndex++;
            otherBtnCount++;
        }
    }
}

- (void)addCancelButton
{
    CGRect btnFrame = CGRectMake(BUTTON_SIDE_OFFSET, viewHeight - BUTTON_HEIGHT, sheetView.frame.size.width - BUTTON_SIDE_OFFSET*2, BUTTON_HEIGHT);
    [self createButton:btnFrame buttonTitile:cancelButtonTitle buttonIndex:(buttonCount-1)];
}

- (void)createButton:(CGRect)frm buttonTitile:(NSString *)title buttonIndex:(NSInteger)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frm;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:index];
    [sheetView addSubview:btn];;
}

- (void)calcButtonCount
{
    buttonCount = 0; //the line number on the sheet
    
    if (cancelButtonTitle) {
        buttonCount++;
    }
    if (destructiveButtonTitle) {
        buttonCount++;
    }
    if (otherButtonTitles.count != 0) {
        for (NSNumber *count in eachLineButtonCount) {
            buttonCount += [count integerValue];
        }
    }
}

- (void)dissmissActionSheet
{
    [UIView animateWithDuration:ANIMATION_DURATION animations:^(void){
        CGRect viewFrame = CGRectMake(0, parentView.frame.size.height, sheetViewWidth, sheetViewHeight);
        [sheetView setFrame:viewFrame];
        fullScreenView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        ((UIViewController*)self.delegate).navigationController.navigationBar.alpha = 1.0;
    } completion:^(BOOL isCompleted){
        [fullScreenView removeFromSuperview];
        [self removeFromSuperview];
        [((UIViewController*)self.delegate).navigationController.navigationBar setUserInteractionEnabled:YES];
    }];
}

- (IBAction)buttonClicked:(UIButton *)sender
{   
    if ([self.delegate conformsToProtocol:@protocol(MBActionSheetDelegate)] &&
        [self.delegate respondsToSelector:@selector(mbactionSheet:clickedButtonAtIndex:)]) {
        [self.delegate mbactionSheet:self clickedButtonAtIndex:[sender tag]];
    } else {
        NSLog(@"Warning: Add the delegate method into your delegate class.");
    }
    
    [self dissmissActionSheet];
}

@end