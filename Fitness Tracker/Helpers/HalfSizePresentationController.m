//
//  HalfSizePresentationController.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 4.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "HalfSizePresentationController.h"

@implementation HalfSizePresentationController

-(CGRect)frameOfPresentedViewInContainerView{
    return CGRectMake(0, self.containerView.bounds.size.height/2, self.containerView.bounds.size.width, self.containerView.bounds.size.height/2);
}

@end
