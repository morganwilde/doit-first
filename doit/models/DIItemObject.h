//
//  DIItemObject.h
//  doit
//
//  Created by Morgan Wilde on 04/05/2013.
//  Copyright (c) 2013 morganwilde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIItemObject : NSObject

@property (weak, nonatomic) NSNumber *number;
@property NSString *content;

-(DIItemObject *)init;
-(DIItemObject *)initWithNumber:(NSNumber *)number andContent:(NSString *)content;

@end
