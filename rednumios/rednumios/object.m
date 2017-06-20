//
//  object.m
//  getjsondemo
//
//  Created by 谭卓 on 16/9/26.
//  Copyright © 2016年 谭卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "object.h"

@implementation RootObject
NSDateFormatter* formatter;
NSDate *date;
@synthesize title,pubtime,author,description,content,logourl,level;

+ (id)objectFromDictionary:(NSDictionary*) dictionary{
    
    return nil;
}
- (id) initWithDictionary:(NSDictionary*) dictionary{
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    self.pid =  [dictionary objectForKey:@"id"];
    self.title = [dictionary objectForKey:@"title"];
    NSNumber* tn =[dictionary objectForKey:@"pubtime"];
    self.author = [dictionary objectForKey:@"author"];
    self.description = [dictionary objectForKey:@"description"];
    self.content = [dictionary objectForKey:@"content"];
    self.logourl = [dictionary objectForKey:@"logourl"];
    NSNumber* ln = [dictionary objectForKey:@"level"];
    
    
    date = [NSDate dateWithTimeIntervalSince1970:[tn longLongValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.pubtime = [dateFormatter stringFromDate:[NSDate date]];
    
    self.content = [self.content substringWithRange:NSMakeRange(0,15)];
    
    int li = [ln intValue];
    
    switch (li) {
        case 0:
            self.level = @"初级";
            break;
        case 1:
            self.level = @"进阶";
            break;
        case 2:
            self.level = @"职业";
            break;
        case 4:
            self.level = @"商业";
            break;
        case 5:
            self.level = @"黑客";
            break;
    }
    
    return self;
}

- (NSMutableDictionary *)toDictionary{
    
    return nil;
}
- (NSDictionary *)map{
    
    return nil;
}
@end
