//
//  DataBaseFile.h
//  01-数据持久化作业
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef DataBaseFile_h
#define DataBaseFile_h





//数据库名称
#define BaseFileName @"Novel.db"
//创建表

#define createTabel @"create table if not exists NovelHome(albumId text,intro text,nickname text, coverSmall blob,coverMiddle blob,coverLarge blob,title text,tracks text,playsCounts text);"
//插入数据
#define INSERT_HOMELIST_SQL @"insert into NovelHome values(:albumId,:intro,:nickname,:coverSmall,:coverMiddle,:coverLarge,:title,:tracks,:playsCounts)"
//查询所有的数据
#define SELECT_HOMELIST_ALL @"select * from NovelHome"

//删除数据
#define Delete_HOMELIST @"delete from NovelHome"

#endif /* DataBaseFile_h */
