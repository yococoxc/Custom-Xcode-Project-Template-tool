//
//  DirectoryContentModel.h
//  testPAth
//
//  Created by muzico on 2018/12/27.
//  Copyright © 2018 muzico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryContentModel : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *fullPath;
@property(nonatomic,strong) NSString *path;
@property(nonatomic,assign) BOOL isFolder;
@property(nonatomic,assign) BOOL hasSub;
@property(nonatomic,strong) NSArray *children;
@property(nonatomic,strong) NSArray <DirectoryContentModel *> *models;

@end
