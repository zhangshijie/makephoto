//
//  PageView.h
//  makephoto
//
//  Created by 张 世杰 on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageView : UIView{
    @private
	CGRect	  _identityFrame;
	NSString *_reuseIdentifier;
}


@property (nonatomic,readwrite,copy) NSString *reuseIdentifier;
@property (nonatomic, assign) CGRect identityFrame;

- (void)prepareForReuse;    // if the page is reusable (has a reuse identifier), this is called just before the cell is returned from HGPageScrollView method dequeueReusablePageWithIdentifier:.  If you override, you MUST call super.

@end
