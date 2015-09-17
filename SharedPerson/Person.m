//
//  Person.m
//  SharedPerson
//
//  Created by qianfeng on 15/9/12.
//  Copyright (c) 2015年 wangli. All rights reserved.
//

#import "Person.h"

//声明一个静态变量指针
static Person *person=nil;

@implementation Person
//mrc and arc
+(Person *)sharedPerson
{
    //考虑线程安全
    @synchronized(self)
    {
        if(person==nil)
        {
            person=[[self alloc] init];
        }
    }
    return person;
}

//arc 下也可以利用gcd队列创建单例对象
+(id)sharedPerson2
{
    static dispatch_once_t once=0;
    static id _sharedObject=nil;
    dispatch_once(&once, ^{
        _sharedObject=[[self alloc] init];
    });
    return _sharedObject;
}
//alloc 创建一个对象时  会执行allocWithZone类方法 所以把这个方法重写
+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if(person==nil)
        {
            person=[super allocWithZone:zone];
        }
    }
    return person;
}

//同理  copy一个对象时  同样会执行  copyWithZone这个方法   重写避免copy出新对象
-(id)copyWithZone:(NSZone *)zone
{
    return self;
}

//在mrc下   避免retain 后，让对象计数加1
-(instancetype)retain
{
    return self;
}

//重写此方法  避免让其他人把对象的计数个数打印出来
-(NSUInteger)retainCount
{
    return UINT_MAX;
}
//在arc中  避免release操作改变对象指针计数  释放对象
-(oneway void)release
{
}
//同理  避免把对象放入自动释放池
-(instancetype)autorelease
{
    return self;
}
@end
