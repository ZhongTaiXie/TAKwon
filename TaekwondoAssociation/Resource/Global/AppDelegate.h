//
//  AppDelegate.h
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/6/26.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

/**
 *  登录成功调用
 */
- (void)goToHome;
/**
 *  退出
 */
- (void)exit;





@end

