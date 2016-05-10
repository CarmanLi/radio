//
//  DataBaseTool.h
//  Radio
//
//  Created by lanou on 16/5/10.
//  Copyright © 2016年 Carman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataBaseTool : NSObject
+(DataBaseTool *)shareDabate;
-(BOOL)creatTable;
-(BOOL)deleteTableWithName:(NSString *)tabeleName;
-(BOOL)deleteTableWithName:(NSString *)tableName withTitle:(NSString *)title;
-(BOOL)insertToTable:(NSString *)tableName withTitle:(NSString *)title andUrl:(NSString *)url;
-(NSMutableArray *)selectTableWithName:(NSString *)tableName;
-(NSMutableArray *)selectTableWithName:(NSString *)tableName withTitle:(NSString *)title;

@end
