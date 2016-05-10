//
//  DataBaseTool.m
//  Radio
//
//  Created by lanou on 16/5/10.
//  Copyright © 2016年 Carman. All rights reserved.
//

#import "DataBaseTool.h"

@interface DataBaseTool()

@property(nonatomic,strong)FMDatabase *db;
@end

@implementation DataBaseTool
static DataBaseTool *dataBase = nil;

+(DataBaseTool *)shareDabate
{
 
    if (dataBase == nil) {
        dataBase = [[DataBaseTool alloc] init];
        
    }
    return dataBase;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"News.sqlite"];
        self.db = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}

-(BOOL)creatTable
{
    if ([_db open]) {
        NSString *sql1 = [NSString stringWithFormat:@"create table if not exists history(id integer primary key autoincrement,title text,url text)"];
        BOOL b1 = [_db executeUpdate:sql1];
        NSString *sql2 = [NSString stringWithFormat:@"create table if not exists collect(id integer primary key autoincrement,title text, url text)"];
        BOOL b2 = [_db executeUpdate:sql2];
        [_db close];
        if (b1 && b2) {
            return YES;
        }
    }
    
    return NO;
}
-(BOOL)deleteTableWithName:(NSString *)tabeleName
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@",tabeleName];
        BOOL b = [_db executeUpdate:sql];
        [_db close];
        return b;
    }
    return NO;
}
-(BOOL)deleteTableWithName:(NSString *)tableName withTitle:(NSString *)title
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where title = '%@'",tableName,title];
        BOOL b = [_db executeUpdate:sql];
        [_db close];
        return b;
    }
    return NO;
    
}
-(BOOL)insertToTable:(NSString *)tableName withTitle:(NSString *)title andUrl:(NSString *)url
{
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"insert into %@(title,url) values('%@','%@')",tableName,title,url];
        BOOL b = [_db executeUpdate:sql];
        [_db close];
        return b;
    }
    return NO;
}
-(NSMutableArray *)selectTableWithName:(NSString *)tableName
{
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"select *from %@",tableName];
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            NSString *title = [set stringForColumn:@"title"];
            NSString *url = [set stringForColumn:@"url"];
//            News *news = [[News alloc] init];
//            news.title = title;
//            news.url = url;
//            [array addObject:news];
            
        }
        [_db close];
        
    }
    return array;
    
}
-(NSMutableArray *)selectTableWithName:(NSString *)tableName withTitle:(NSString *)title
{
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"select *from %@ where title = '%@'",tableName,title];
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            NSString *title = [set stringForColumn:@"title"];
            NSString *url = [set stringForColumn:@"url"];
//            News *news = [[News alloc] init];
//            news.title = title;
//            news.url = url;
//            [array addObject:news];
            
        }
        [_db close];
        
    }
    return array;
    
    
}


@end
