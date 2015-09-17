//
//  Person.h
//  SharedPerson
//
//  Created by qianfeng on 15/9/12.
//  Copyright (c) 2015年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

//对外公开单例类方法
+(Person *)sharedPerson;

@end
