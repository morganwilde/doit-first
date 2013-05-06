//
//  DIItemListLabel.m
//  doit
//
//  Created by Morgan Wilde on 04/05/2013.
//  Copyright (c) 2013 morganwilde. All rights reserved.
//

#import "DIItemListLabel.h"

@implementation DIItemListLabel

- (id)initWithItemObject:(DIItemObject *)itemObject
{
    NSNumber *itemNumber = [itemObject number];
    NSString *itemContent = [itemObject content];
    //NSLog(@"%@", itemNumber);
    
    // Standard values
    int         itemStandardHeight      = 20;
    int         itemStandardWidth       = 240;
    NSArray     *itemStandardPadding    = @[@0.0, @0.0, @0.0, @0.0]; // Top, Right, Bottom, Left
    
    // Item values
    int itemHeight = itemStandardHeight;
    int itemWidth = itemStandardWidth;
    float itemPositionX = [[itemStandardPadding objectAtIndex:3] floatValue];
    float itemPositionY = [[itemStandardPadding objectAtIndex:0] floatValue] + [itemNumber intValue]*itemStandardHeight;//itemStandardPadding[0];
    
    self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemPositionX, itemPositionY, itemWidth, itemHeight)];
    self.itemLabel.font = [UIFont systemFontOfSize:14.0];
    self.itemLabel.textColor = [UIColor blackColor];
    self.itemLabel.backgroundColor = [UIColor clearColor];
    self.itemLabel.text = [NSString stringWithFormat:@"%02d - %@", [itemNumber intValue], itemContent];
    return self;
}

@end
