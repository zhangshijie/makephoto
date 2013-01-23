//
//  TextViewController.h
//  makephoto
//
//  Created by 张 世杰 on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *InputText;
- (IBAction)CompleteInput:(id)sender;
- (IBAction)BackButtonOnClick:(id)sender;
@end
