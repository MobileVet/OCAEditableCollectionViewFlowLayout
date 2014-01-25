//
//  OCAEditableLayoutAttributes.m
//  KOResume
//
//  Created by Kevin O'Mara on 8/31/13.
//  Copyright (c) 2013 O'Mara Consulting Associates. All rights reserved.
//

#import "OCAEditableLayoutAttributes.h"

@implementation OCAEditableLayoutAttributes

//----------------------------------------------------------------------------------------------------------
- (id)copyWithZone:(NSZone *)zone
{
    OCAEditableLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.deleteButtonHidden           = _deleteButtonHidden;
    
    return attributes;
}


//----------------------------------------------------------------------------------------------------------
-(BOOL)isEqual:(id)object
{
    // First, call super to see if the base layout attributes are equal
    BOOL result = [super isEqual:object];

    // If the base attributes are equal and the object is of our class
    if (result && [object isKindOfClass:[self class]]) {
        // Compare to our attributes and AND the result with the base result
        return result && self.deleteButtonHidden == ((OCAEditableLayoutAttributes *) object).deleteButtonHidden;
    }
    
    return result;
}

@end
