//
//  FZCarouselView.h
//  FZCarousel
//
//  Created by Sheng Dong on 9/25/15.
//  Copyright © 2015 Fuzz Productions, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FZCarouselCollectionViewDelegate.h"


@interface FZDefaultCarouselCollectionViewDelegate : FZCarouselCollectionViewDelegate
@end

/**
 * @description FZCarouselView is view with default implementation of FZCarouselCollectionViewDelegate that takes an array of images for an infinitely scrolling carousel.
 *
 * @discussion Use it like a standard view with or without storyboard.
 */

@interface FZCarouselView : UIView

@property (readonly, nonatomic) FZDefaultCarouselCollectionViewDelegate *carouselCollectionViewDelegate;
@property (readonly, nonatomic) UICollectionView *collectionView;


@property (nonatomic, strong) NSArray<UIImage *> *imageArray;
@property (nonatomic, strong) NSArray <UIButton *> *buttonArray;
@property (nonatomic) BOOL gestureRecognitionShouldEndCarousel;
@property (nonatomic, assign) NSTimeInterval crankInterval; // Three Seconds by default

- (void)beginCarousel;

@end
