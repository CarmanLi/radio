//
//  NetworkRequestManager.h
//  One
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Carman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,RequestType) {
    GET,
    POST
};
//定义一个block作为回调
typedef void(^RequestFinish) (NSData *data);
typedef void(^RequestError) (NSError *error);

@interface NetworkRequestManager : NSObject

//声明一个类方法
+(void)requestWithType:(RequestType)type urlString:(NSString *)urlString PraDic:(NSDictionary *)dic andHeader:(NSDictionary *)headerDic finish:(RequestFinish)finish error:(RequestError)err;

@end
