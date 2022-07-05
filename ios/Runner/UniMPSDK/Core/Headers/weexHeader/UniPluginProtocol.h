//
//  UniPluginProtocol.h
//  libWeex
//
//  Created by 4Ndf on 2018/11/30.
//  Copyright © 2018年 DCloud. All rights reserved.
//
#import <UIKit/UIApplication.h>
@protocol UniPluginProtocol <NSObject>
//@required // 必须实现的方法
-(void)onCreateUniPlugin;

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions;
- (void)application:(UIApplication *_Nullable)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *_Nullable)deviceToken;
- (void)application:(UIApplication *_Nullable)application didFailToRegisterForRemoteNotificationsWithError:(NSError *_Nullable)err;
- (void)application:(UIApplication *_Nullable)application didReceiveRemoteNotification:(NSDictionary *_Nullable)userInfo;
- (void)application:(UIApplication *_Nullable)application didReceiveRemoteNotification:(NSDictionary *_Nullable)userInfo fetchCompletionHandler:(void (^_Nullable)(UIBackgroundFetchResult))completionHandler;
- (void)application:(UIApplication *_Nullable)application didReceiveLocalNotification:(UILocalNotification *_Nullable)notification;
- (BOOL)application:(UIApplication *_Nullable)application handleOpenURL:(NSURL *_Nullable)url;
- (BOOL)application:(UIApplication *_Nullable)application openURL:(NSURL *_Nullable)url sourceApplication:(NSString *_Nullable)sourceApplication annotation:(id _Nonnull )annotation;
- (BOOL)application:(UIApplication *_Nullable)app openURL:(NSURL *_Nonnull)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *_Nullable)options NS_AVAILABLE_IOS(9_0);

- (void)applicationWillResignActive:(UIApplication * _Nullable)application;
- (void)applicationDidBecomeActive:(UIApplication *_Nullable)application;
- (void)applicationDidEnterBackground:(UIApplication *_Nullable)application;
- (void)applicationWillEnterForeground:(UIApplication *_Nullable)application;
- (void)applicationWillTerminate:(UIApplication *_Nullable)application;
- (void)applicationDidReceiveMemoryWarning:(UIApplication *_Nullable)application;
- (void)application:(UIApplication *_Nullable)application performActionForShortcutItem:(UIApplicationShortcutItem *_Nullable)shortcutItem completionHandler:(void (^_Nullable)(BOOL))completionHandler API_AVAILABLE(ios(9.0));
- (void)application:(UIApplication *_Nullable)application handleEventsForBackgroundURLSession:(NSString *_Nonnull)identifier completionHandler:(void (^_Nullable)(void))completionHandler;
- (BOOL)application:(UIApplication *_Nullable)application continueUserActivity:(NSUserActivity *_Nullable)userActivity restorationHandler:(void(^_Nullable)(NSArray * __nullable restorableObjects))restorationHandler API_AVAILABLE(ios(8.0));

@end
