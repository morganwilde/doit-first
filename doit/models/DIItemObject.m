//
//  DIItemObject.m
//  doit
//
//  Created by Morgan Wilde on 04/05/2013.
//  Copyright (c) 2013 morganwilde. All rights reserved.
//

#import "DIItemObject.h"

@implementation DIItemObject

-(DIItemObject *)init
{
    self.number     = @0;
    self.content    = @"";
    return self;
}
-(DIItemObject *)initWithNumber:(NSNumber *)number andContent:(NSString *)content
{
    //self.number     = number;
    [self setNumber:number];
    //self.content    = content;
    [self setContent:content];
    return self;
}

@end
