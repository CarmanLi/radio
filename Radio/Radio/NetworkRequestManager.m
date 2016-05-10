//
//  NetworkRequestManager.m
//  One
//
//  Created by lanou on 16/4/12.
//  Copyright © 2016年 Carman. All rights reserved.
//

#import "NetworkRequestManager.h"

@implementation NetworkRequestManager
+(void)requestWithType:(RequestType)type urlString:(NSString *)urlString PraDic:(NSDictionary *)dic andHeader:(NSDictionary *)headerDic finish:(RequestFinish)finish error:(RequestError)err
{
    NetworkRequestManager *manager = [[NetworkRequestManager alloc] init];
    [manager requestWithType:type urlString:urlString PraDic:dic andHeader:headerDic finish:finish error:err];
}
-(void)requestWithType:(RequestType)type urlString:(NSString *)urlString PraDic:(NSDictionary *)pardic andHeader:(NSDictionary *)headerDic finish:(RequestFinish)finish error:(RequestError)err
{
    //1
    NSURL *url = [NSURL URLWithString:urlString];
    //2
    NSMutableURLRequest *mrequest = [NSMutableURLRequest requestWithURL:url];
    //3
    if (type == POST) {
        //设置请求类型
        [mrequest setHTTPMethod:@"POST"];
        
        
        //设置Body类型
        if (pardic.count>0) {
            // 将dic转化为NSData
            NSData *data = [self DicToData:pardic];
            [mrequest setHTTPBody:data];
        }
    }
    
    if (headerDic != nil) {
        mrequest.allHTTPHeaderFields = headerDic;
    }
    
    
    //4进行网络请求
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
             finish(data);
        }else{
            err(error);
        }
    }];
    [task resume];
    

}
#pragma mark 将dic转化为NSData的私有方法
-(NSData *)DicToData:(NSDictionary *)dic
{
    NSMutableArray *marray = [NSMutableArray array];
    for (NSString *key in dic) {
        NSString *valueAndKey = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        [marray addObject:valueAndKey];
    }
    NSString *parStr = [marray componentsJoinedByString:@"&"];
    
    //将字符串转化为data
    NSData *data = [parStr dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

@end
