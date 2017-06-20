//
//  object.h
//  getjsondemo
//
//  Created by 谭卓 on 16/9/26.
//  Copyright © 2016年 谭卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface RootObject : Jastor

@property (nonatomic) NSNumber* pid;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* pubtime;
@property (nonatomic) NSString* author;
@property (nonatomic) NSString* description;
@property (nonatomic) NSString* content;
@property (nonatomic) NSString* logourl;
@property (nonatomic) NSString* level;
@end
