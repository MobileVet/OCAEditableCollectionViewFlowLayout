//
//  OCAEditableCollectionViewFlowLayoutCell.m
//  KOResume
//
//  Created by Kevin O'Mara on 10/28/13.
//  Copyright (c) 2013-2014 O'Mara Consulting Associates. All rights reserved.
//

#import "OCADebug.h"
#import "OCAEditableCollectionViewFlowLayoutCell.h"
#import "OCAEditableLayoutAttributes.h"
#import "OCAEditableCollectionViewFlowLayout.h"

#define MARGIN 10

@interface OCAEditableCollectionViewFlowLayoutCell ()

@end

@implementation OCAEditableCollectionViewFlowLayoutCell


static UIImage *deleteButtonImg;

//----------------------------------------------------------------------------------------------------------
- (void)awakeFromNib
{
    DLog();
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor darkGrayColor];
    
    self.layer.cornerRadius                         = 5.0f;
    self.viewForBaselineLayout.layer.cornerRadius   = 2.0f;
    
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    if (!deleteButtonImg)
    {
        CGRect buttonFrame  = self.deleteButton.frame;
        UIGraphicsBeginImageContext(buttonFrame.size);
        
        CGContextRef context    = UIGraphicsGetCurrentContext();
        CGSize  myShadowOffset  = CGSizeMake (1,  3);
        CGContextSaveGState(context);
        CGContextSetShadow (context, myShadowOffset, 5);

        CGFloat sz          = MIN(buttonFrame.size.width, buttonFrame.size.height);
        UIBezierPath *path  = [UIBezierPath bezierPathWithArcCenter: CGPointMake(buttonFrame.size.width/2, buttonFrame.size.height/2)
                                                             radius: sz/2-2
                                                         startAngle: 0
                                                           endAngle: M_PI * 2
                                                          clockwise: YES];
        [path moveToPoint: CGPointMake(MARGIN, MARGIN)];
        [path addLineToPoint: CGPointMake(sz-MARGIN, sz-MARGIN)];
        [path moveToPoint: CGPointMake(MARGIN, sz-MARGIN)];
        [path addLineToPoint: CGPointMake(sz-MARGIN, MARGIN)];
        
        if (IOS_7_0_OR_ABOVE) {
            [[self tintColor] setFill];
        }
        
        [[UIColor lightGrayColor] setStroke];
        [path setLineWidth: 2.0];
        [path fill];
        [path stroke];
#warning TODO - add drop shadow
//        CALayer *sublayer = [CALayer layer];
//        sublayer.backgroundColor = [UIColor blueColor].CGColor;
//        sublayer.shadowOffset = CGSizeMake(0, 3);
//        sublayer.shadowRadius = 5.0;
//        sublayer.shadowColor = [UIColor blackColor].CGColor;
//        sublayer.shadowOpacity = 0.8;
//        sublayer.frame = CGRectMake(30, 30, 128, 192);
        [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [self.layer setShadowOffset:CGSizeMake(1.0, 3.0)];
        [self.layer setShadowOpacity:0.5];
        [self.layer setShadowRadius:3.f];
//        [self.view.layer addSublayer:sublayer];
        
        deleteButtonImg = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRestoreGState(context);
        UIGraphicsEndImageContext();
    }
    // Set the image for the delete button
    [self.deleteButton setImage: deleteButtonImg
                       forState: UIControlStateNormal];
    // ...and the handler for button presses
    [self.deleteButton addTarget: self
                          action: @selector(didPressDeleteButton)
                forControlEvents: UIControlEventTouchUpInside];
    // ...make if hidden initially
    [self.deleteButton setHidden: YES];
    // ...and add it to the cell's contentView
    [self.contentView addSubview: self.deleteButton];
}


//----------------------------------------------------------------------------------------------------------
- (void)startQuivering
{
    DLog();
    
    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath: @"transform.rotation"];
    
    float startAngle    = (-2) * M_PI/180.0;
    float stopAngle     = -startAngle;
    
    quiverAnim.fromValue    = @(startAngle);
    quiverAnim.toValue      = @(3 * stopAngle);
    quiverAnim.autoreverses = YES;
    quiverAnim.duration     = 0.2;
    quiverAnim.repeatCount  = HUGE_VALF;
    float timeOffset        = (float)(arc4random() % 100)/100 - 0.50;
    quiverAnim.timeOffset   = timeOffset;
    CALayer *layer          = self.layer;
    
    [layer addAnimation: quiverAnim
                 forKey: @"quivering"];
}


//----------------------------------------------------------------------------------------------------------
- (void)stopQuivering
{
    DLog();
    
    CALayer *layer = self.layer;
    [layer removeAnimationForKey:@"quivering"];
}

//----------------------------------------------------------------------------------------------------------
- (void)applyLayoutAttributes:(OCAEditableLayoutAttributes *)layoutAttributes
{
    DLog();
    
    // TODO - see if we can use UIKitDynamics for the quivering behavior
    if (layoutAttributes.isDeleteButtonHidden) {
        [self.deleteButton setHidden:YES];
        [self stopQuivering];
    } else {
        [self.deleteButton setHidden:NO];
        [self startQuivering];
    }
}

//----------------------------------------------------------------------------------------------------------
- (void)didPressDeleteButton
{
    assert(self.deleteDelegate);
    DLog();
    
    [_deleteDelegate deleteCell: self];
}

@end
