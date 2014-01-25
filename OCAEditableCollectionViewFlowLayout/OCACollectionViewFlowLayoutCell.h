//
//  OCACollectionViewFlowLayoutCell.h
//  KOResume
//
//  Created by Kevin O'Mara on 10/28/13.
//  Copyright (c) 2013-2014 O'Mara Consulting Associates. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 An object that adopts the OCACollectionViewFlowLayoutCellDelegate protocol must support delete operations
 */
@protocol OCACollectionViewFlowLayoutCellDelegate

@required

/**
 This method will be invokde on the deleteDelegate when the user presses the delete button
 
 @param cellCenterPoint     the CGPoint of the center of the cell's contentView. The delegateDelegate will use it to located the indexPath that represents the cell.
 */
- (void)didPressDeleteButton:(CGPoint)cellCenterPoint;

@end

/**
 This class supports deletable collection view cells
 */
@interface OCACollectionViewFlowLayoutCell : UICollectionViewCell

/**
 The IBOutlet for the delete button
 */
@property (nonatomic, strong)   IBOutlet UIButton   *deleteButton;

@end
