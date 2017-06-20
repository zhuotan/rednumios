//
//  Jastor.h
//  getjsondemo
//
//  Created by 谭卓 on 16/9/24.
//  Copyright © 2016年 谭卓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jastor : NSObject <NSCoding>
+ (id)objectFromDictionary:(NSDictionary*) dictionary;
- (id)initWithDictionary:(NSDictionary*) dictionary;
- (NSMutableDictionary *)toDictionary;
- (NSDictionary *)map;
@end
