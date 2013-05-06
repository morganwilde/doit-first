//
//  DIItemListLabel.h
//  doit
//
//  Created by Morgan Wilde on 04/05/2013.
//  Copyright (c) 2013 morganwilde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../models/DIItemObject.h"

@interface DIItemListLabel : UIViewController
@property (nonatomic) IBOutlet UILabel *itemLabel;
- (id)initWithItemObject:(DIItemObject *)itemObject;
@end
