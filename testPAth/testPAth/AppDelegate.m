//
//  AppDelegate.m
//  testPAth
//
//  Created by muzico on 2018/12/27.
//  Copyright © 2018 muzico. All rights reserved.
//

#import "AppDelegate.h"
#import "DirectoryContentModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSArray *all = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *name in all) {
        if ([name isEqualToString:@".DS_Store"] == NO) {
            NSString *fullPath = [path stringByAppendingPathComponent:name];
            
            NSError *error = nil;
            NSArray *subAll = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fullPath error:&error];
            if (error == nil) {
                DirectoryContentModel *model = [DirectoryContentModel new];
                model.isFolder = YES;
                model.fullPath = fullPath;
                model.name = name;
                model.path = name;
                
                NSMutableArray *targetSubAll = [NSMutableArray array];
                for (NSString *name in subAll) {
                    if ([name isEqualToString:@".DS_Store"] == NO) {
                        [targetSubAll addObject:name];
                    }
                }
                if ([targetSubAll count] > 0) {
                    model.hasSub = YES;
                    model.children = targetSubAll;
                }
                [self allSubmodelWithModel:model];
                
                [self createPlistFileWithModel:model];
                
            } else {
                NSLog(@" %@ XXXXXX",name);
            }
        }
    }
    
    return YES;
}

- (void) allSubmodelWithModel:(DirectoryContentModel *) model {
    NSMutableArray *targetArray = [NSMutableArray array];
    
    BOOL canHaveSub = YES;
    if ([model.name hasSuffix:@"framework"]) {
        canHaveSub = NO;
        
        DirectoryContentModel *tempModel = [DirectoryContentModel new];
        tempModel.name = model.name;
        tempModel.path = model.path;
        [targetArray addObject:tempModel];
    }
    
    if (canHaveSub && model.hasSub) {
        for (NSString *name in model.children) {
            DirectoryContentModel *tempModel = [DirectoryContentModel new];
            tempModel.name = name;
            tempModel.path = [model.path stringByAppendingPathComponent:name];
            
            NSString *fullPath = [model.fullPath stringByAppendingPathComponent:name];
            tempModel.fullPath = fullPath;
            
            NSError *error = nil;
            NSArray *subAll = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fullPath error:&error];
            if (error == nil) {
                tempModel.isFolder = YES;
                
                NSMutableArray *targetSubAll = [NSMutableArray array];
                for (NSString *tempName in subAll) {
                    if ([tempName isEqualToString:@".DS_Store"] == NO) {
                        [targetSubAll addObject:tempName];
                    }
                }
                if ([targetSubAll count] > 0) {
                    tempModel.hasSub = YES;
                    tempModel.children = targetSubAll;
                    
                    [self allSubmodelWithModel:tempModel];
                }
                
            } else {
                //                NSLog(@" %@ XXXXXX",name);
            }
            [targetArray addObject:tempModel];
        }
    } else {
        
    }
    model.models = targetArray;
}


- (void) createPlistFileWithModel:(DirectoryContentModel *) model {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"Xcode.Xcode3.ProjectTemplateUnitKind" forKey:@"Kind"];
    
    [dic setObject:@"com.muzico.LQSApplication" forKey:@"Identifier"];
    
    NSMutableArray *Ancestors = [NSMutableArray array];
    [Ancestors addObject:@"com.apple.dt.unit.storyboardApplication"];
    [Ancestors addObject:@"com.apple.dt.unit.coreDataCocoaTouchApplication"];
    [dic setObject:Ancestors forKey:@"Ancestors"];
    
    [dic setObject:[NSNumber numberWithBool:YES] forKey:@"Concrete"];
    
    [dic setObject:@"This template provides a starting point for an application that uses a single view. It provides a view controller to manage the view, and a storyboard or nib file that contains the view." forKey:@"Description"];
    
    [dic setObject:[NSNumber numberWithInteger:1] forKey:@"SortOrder"];
    
    NSArray *aaaa = [self allSubPathWithModel:model];
    
    NSMutableArray *Options = [NSMutableArray array];
    {
        NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
        [dicc setObject:@"languageChoice" forKey:@"Identifier"];
        
        NSMutableDictionary *Units = [NSMutableDictionary dictionary];
        {
            NSMutableDictionary *oc = [NSMutableDictionary dictionary];
            NSMutableArray *Nodes = [NSMutableArray array];
            {
                [Nodes addObjectsFromArray:aaaa];
                
                {
                    [Nodes addObject:@"ViewController.h:comments"];
                    [Nodes addObject:@"ViewController.h:imports:importCocoa"];
                    [Nodes addObject:@"ViewController.h:interface(___FILEBASENAME___ : UIViewController)"];
                    [Nodes addObject:@"ViewController.m:comments"];
                    [Nodes addObject:@"ViewController.m:imports:importHeader:ViewController.h"];
                    [Nodes addObject:@"ViewController.m:extension"];
                    [Nodes addObject:@"ViewController.m:implementation:methods:viewDidLoad(- (void\\)viewDidLoad)"];
                    [Nodes addObject:@"ViewController.m:implementation:methods:viewDidLoad:super"];
                    [Nodes addObject:@"ViewController.m:implementation:methods:didReceiveMemoryWarning(- (void\\)didReceiveMemoryWarning)"];
                    [Nodes addObject:@"ViewController.m:implementation:methods:didReceiveMemoryWarning:super"];
                }
                {
                    [Nodes addObject:@"AppDelegate.h"];
                    [Nodes addObject:@"AppDelegate.m"];
                    [Nodes addObject:@"Info.plist"];
                }
            }
            [oc setObject:Nodes forKey:@"Nodes"];
            [Units setObject:oc forKey:@"Objective-C"];
        }
        {
            NSMutableDictionary *Swift = [NSMutableDictionary dictionary];
            [Units setObject:Swift forKey:@"Swift"];
        }
        [dicc setObject:Units forKey:@"Units"];
        [Options addObject:dicc];
    }
    [dic setObject:Options forKey:@"Options"];
    
    
    NSMutableDictionary *Definitions = [NSMutableDictionary dictionary];
    {
        for (NSString *path in aaaa) {
            NSMutableDictionary *diccc = [NSMutableDictionary dictionary];
            [diccc setObject:path forKey:@"Path"];
            NSMutableArray *Group = [NSMutableArray array];
            {
                NSArray *tempArray = [path componentsSeparatedByString:@"/"];
                for (NSInteger index = 0; index < [tempArray count] - 1; index++) {
                    [Group addObject:[tempArray objectAtIndex:index]];
                }
            }
            [diccc setObject:Group forKey:@"Group"];
            [Definitions setObject:diccc forKey:path];
        }
        
        NSMutableDictionary *dicccdd = [NSMutableDictionary dictionary];
        {
            [dicccdd setObject:@"Main.storyboard" forKey:@"Path"];
            [dicccdd setObject:[NSNumber numberWithInteger:99] forKey:@"SortOrder"];
        }
        [Definitions setObject:dicccdd forKey:@"Base.lproj/Main.storyboard"];
        
        {
            NSMutableDictionary *AppDelegateH = [NSMutableDictionary dictionary];
            {
                [AppDelegateH setObject:@"AppDelegate.h" forKey:@"Path"];
            }
            [Definitions setObject:AppDelegateH forKey:@"AppDelegate.h"];
            NSMutableDictionary *AppDelegateM = [NSMutableDictionary dictionary];
            {
                [AppDelegateM setObject:@"AppDelegate.m" forKey:@"Path"];
            }
            [Definitions setObject:AppDelegateM forKey:@"AppDelegate.m"];
            NSMutableDictionary *Info_plist = [NSMutableDictionary dictionary];
            {
                [Info_plist setObject:@"Info.plist" forKey:@"Path"];
            }
            [Definitions setObject:Info_plist forKey:@"Info.plist"];
        }
    }
    [dic setObject:Definitions forKey:@"Definitions"];
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *keepPath = [path stringByAppendingPathComponent:@"TemplateInfo.plist"];
    [dic writeToFile:keepPath atomically:YES];
}

- (NSArray *) allSubPathWithModel:(DirectoryContentModel *)model {
    NSMutableArray *keepArray = [NSMutableArray array];
    
    if (model.hasSub) {
        for (DirectoryContentModel *tempModel in model.models) {
            if (tempModel.hasSub) {
                [keepArray addObjectsFromArray:[self allSubPathWithModel:tempModel]];
            } else {
                [keepArray addObject:tempModel.path];
            }
        }
    } else {
        [keepArray addObject:model.path];
    }
    return keepArray;
}

@end
