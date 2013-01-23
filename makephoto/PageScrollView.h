//
//  PageScrollView.h
//  makephoto
//
//  Created by 张 世杰 on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"



typedef enum{
	HGPageScrollViewModePage,
	HGPageScrollViewModeDeck 
}PageScrollViewMode; 

@class PageScrollView;

@protocol PageScrollViewDataSource <NSObject>

@required 
- (PageView *)pageScrollView:(PageScrollView *)scrollview viewForPageIndex:(NSInteger)index;

@end


@protocol PageScrollViewDelegate <NSObject,UIScrollViewDelegate>

// Dragging
- (void) pageScrollViewWillBeginDragging:(PageScrollView *)scrollView;
- (void) pageScrollViewDidEndDragging:(PageScrollView *)scrollView willDecelerate:(BOOL)decelerate;

// Decelaration
- (void)pageScrollViewWillBeginDecelerating:(PageScrollView *)scrollView;
- (void)pageScrollViewDidEndDecelerating:(PageScrollView *)scrollView;

// Called before the page scrolls into the center of the view.
- (void)pageScrollView:(PageScrollView *)scrollView willScrollToPage:(PageView*)page atIndex:(NSInteger)index;

// Called after the page scrolls into the center of the view.
- (void)pageScrollView:(PageScrollView *)scrollView didScrollToPage:(PageView*)page atIndex:(NSInteger)index;

// Called before the user changes the selection.
- (void)pageScrollView:(PageScrollView *)scrollView willSelectPageAtIndex:(NSInteger)index;
- (void)pageScrollView:(PageScrollView *)scrollView willDeselectPageAtIndex:(NSInteger)index;

// Called after the user changes the selection.
- (void)pageScrollView:(PageScrollView *)scrollView didSelectPageAtIndex:(NSInteger)index;
- (void)pageScrollView:(PageScrollView *)scrollView didDeselectPageAtIndex:(NSInteger)index;

@end

@class TouchView;

@interface PageScrollView : UIView<UIScrollViewDelegate>{
    
    @private
    
    PageView         *selectedPage;
    
    NSInteger        numberOfPages;
    
    UIPageControl    *pageSelector;
    
    TouchView	*_scrollViewTouch;
	
	UIPageControl	*_pageSelector;
    
	TouchView	*_pageSelectorTouch;
    
    UIScrollView *scrollView;
    
    NSInteger cx;
    
//    UIScrollView *scrollView;
    
}
    
    

//- (NSInteger) numberOfPages;
- (PageView *)pageAtIndex:(NSInteger)index;

@property (nonatomic,strong) UIView *page;
@property (nonatomic,assign) NSInteger numberOfPages;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *scrollView;

- (void) insertPagesAtIndexs:(UIView *) addedView withOriginX:(CGFloat )CX  withIndex:(NSInteger *)indexs animated:(BOOL)animals;
- (void) deletePagesAtIndexs:(NSInteger *)indexs animaated:(BOOL)animals;
- (void) addIndexAtPageControl;
- (void) removeIndexAtPageControl;


@end
