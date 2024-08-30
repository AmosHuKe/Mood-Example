//
//  DCUniMPSDKEngine.h
//  DCUniMP
//
//  Created by XHY on 2020/1/14.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DCUniMPInstance.h"
#import "DCUniMPMenuActionSheetStyle.h"

/// 加载小程序 block 回调
/// uniMPInstance: 加载成功返回小程序实例，失败则为 nil
/// error：失败信息
typedef void(^DCUniMPCompletionBlock)(DCUniMPInstance *_Nullable uniMPInstance, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@protocol DCUniMPSDKEngineDelegate <NSObject>

///
/// 回调数据给小程序
/// result：回调参数支持 NSString 或 NSDictionary 类型
/// keepAlive：如果 keepAlive 为 YES，则可以多次回调数据给小程序，反之触发一次后回调方法即被移除
typedef void (^DCUniMPKeepAliveCallback)(id result, BOOL keepAlive);

@optional
/// 拦截胶囊`x`关闭按钮事件，注意：实现该方法后框架内不会执行关闭小程序的逻辑，需要宿主自行处理逻辑
/// @param appid appid
- (void)hookCapsuleCloseButtonClicked:(NSString *)appid;

/// 拦截胶囊`···`菜单按钮事件，注意：实现该方法后框架内不会弹出actionSheet弹窗，需宿主自行处理逻辑
/// @param appid appid
- (void)hookCapsuleMenuButtonClicked:(NSString *)appid;

/// 胶囊按钮‘x’关闭按钮点击回调
/// @param appid appid
- (void)closeButtonClicked:(NSString *)appid;

/// 胶囊按钮菜单 ActionSheetItem 点击回调方法
/// @param appid appid
/// @param identifier item 项的标识
- (void)defaultMenuItemClicked:(NSString *)appid identifier:(NSString *)identifier;

/// 返回打开小程序时的闪屏视图
/// @param appid appid
- (UIView *)splashViewForApp:(NSString *)appid;

/// 关闭小程序的回调方法
/// @param appid appid
- (void)uniMPOnClose:(NSString *)appid;

/// 小程序向原生发送事件回调方法
/// @param appid 对应小程序的appid
/// @param event 事件名称
/// @param data 数据：NSString 或 NSDictionary 类型
/// @param callback 回调数据给小程序
- (void)onUniMPEventReceive:(NSString *)appid event:(NSString *)event data:(id)data callback:(DCUniMPKeepAliveCallback)callback;

#pragma mark - deprecated (废弃API)
/// 胶囊按钮菜单 ActionSheetItem 点击回调方法
/// @param identifier item 项的标识
- (void)defaultMenuItemClicked:(NSString *)identifier __attribute__((deprecated("Use -defaultMenuItemClicked:identifier:")));

/// 小程序向原生发送事件回调方法
/// @param event 事件名称
/// @param data 数据：NSString 或 NSDictionary 类型
/// @param callback 回调数据给小程序
- (void)onUniMPEventReceive:(NSString *)event data:(id)data callback:(DCUniMPKeepAliveCallback)callback __attribute__((deprecated("Use -onUniMPEventReceive:event:data:callback:")));

@end

@interface DCUniMPSDKEngine : NSObject

#pragma mark - SDK 全局生命周期方法
/// 初始化 sdk 全局环境
/// @param options 启动参数
+ (void)initSDKEnvironmentWithLaunchOptions:(NSDictionary *)options;

/// 释放SDK资源
+ (void)destory;

/// 设置是否开启 web 内容检查器（iOS16.4 及以上版本有效）
+ (void)setWebContentInspection:(BOOL)inspectable;

#pragma mark - 小程序应用相关方法

/// 小程序打开状态，调用此方法可获取小程序对应的 DCUniMPViewController 实例
+ (UIViewController *)getUniMPViewController;

/// 获取 App 运行路径，注：需要将应用资源放到此路径下
/// @param appid appid
+ (NSString *)getUniMPRunPathWithAppid:(NSString *)appid;

/// 运行目录中是否已经存在小程序资源
/// @param appid appid
+ (BOOL)isExistsUniMP:(NSString *)appid;

/// 将wgt资源部署到运行路径中
/// @param appid appid
/// @param wgtPath wgt资源路径
/// @param password wgt资源解压密码（没有密码传 nil）
/// @param error 解压报错对应的 Error
+ (BOOL)installUniMPResourceWithAppid:(NSString *)appid
                     resourceFilePath:(NSString *)wgtPath
                             password:(nullable NSString *)password
                                error:(NSError * *)error;

/// 启动小程序
/// @param appid appid
/// @param configuration 小程序的配置信息
/// @param completionBlock 方法执行回调
+ (void)openUniMP:(NSString *)appid
    configuration:(DCUniMPConfiguration *)configuration
        completed:(DCUniMPCompletionBlock)completionBlock;

/// 预加载小程序
/// @param appid appid
/// @param configuration 小程序的配置信息
/// @param completionBlock 方法执行回调
+ (void)preloadUniMP:(NSString *)appid
       configuration:(DCUniMPConfiguration * __nullable)configuration
           completed:(DCUniMPCompletionBlock)completionBlock;

/// 关闭当前显示的小程序应用
+ (void)closeUniMP;

/// 获取当前显示的小程序appid
+ (NSString *)getActiveUniMPAppid;


/// 获取当前显示小程序页面的直达链接url
+ (NSString *)getCurrentPageUrl;


/// 获取已经部署的小程序应用资源版本信息
/// @param appid appid
/// 返回数据为 manifest 中的配置信息
/// {
///     "name": "1.0.0",     // 应用版本名称
///     "code": 100          // 应用版本号
/// }
+ (NSDictionary *__nullable)getUniMPVersionInfoWithAppid:(NSString *)appid;

/// 小程序页面关闭时设置原生导航栏的显隐 （请使用此方法来控制进入小程序页面或离开小程序页面导航栏的显隐，不然导航栏的显隐效果不好，可能会出现闪一下的情况）
/// 说明：当小程序是通过 DCUniMPOpenModePush 方式打开（即通过原生导航控制器push方式打开小程序页面）如果系统导航栏是显示状态，进入小程序时会隐藏系统导航栏并在小程序页面关闭或从小程序页面在 push 到宿主其他原生页面时会将系统导航栏恢复之前的显隐状态；如果您想控制导航栏的显隐可通过此方法来实现
/// 场景：在显示系统导航栏的页面 push 进入小程序页面，从小程序页面 push 到其他原生页面时需要隐藏系统导航栏，则可以在跳转页面前调用此方法来处理；
/// 注意：只有通过 push 的方式打开小程序才生效
/// @param hidden 是否隐藏
+ (void)whenUniMPCloseSetNavigationBarHidden:(BOOL)hidden;

/// 设置 push 打开方式小程序内是否自动控制原生导航栏的显隐（默认控制）
/// @param isControl Bool
+ (void)setAutoControlNavigationBar:(BOOL)isControl;

#pragma mark - 胶囊按钮相关方法

/// 配置胶囊按钮样式
/// @param capsuleButtonStyle DCUniMPCapsuleButtonStyle
+ (void)configCapsuleButtonStyle:(DCUniMPCapsuleButtonStyle *)capsuleButtonStyle;

/// 设置导航栏上的胶囊按钮显示还是隐藏（默认显示）
/// @param capsuleButtonHidden Bool 是否隐藏胶囊按钮
+ (void)setCapsuleButtonHidden:(BOOL)capsuleButtonHidden;

/// 配置点击菜单按钮弹出 ActionSheet 视图的样式
/// @param menuActionSheetStyle DCUniMPMenuActionSheetStyle
+ (void)configMenuActionSheetStyle:(DCUniMPMenuActionSheetStyle *)menuActionSheetStyle;

/// 配置胶囊按钮菜单 ActionSheet 全局项
/// @param items DCUniMPMenuActionSheetItem 数组
+ (void)setDefaultMenuItems:(NSArray<DCUniMPMenuActionSheetItem *> *)items;


/// 设置 DCUniMPSDKEngineDelegate
/// @param delegate 代理对象
+ (void)setDelegate:(id<DCUniMPSDKEngineDelegate>)delegate;

#pragma mark - App 生命周期方法
+ (void)applicationDidBecomeActive:(UIApplication *)application;
+ (void)applicationWillResignActive:(UIApplication *)application;
+ (void)applicationDidEnterBackground:(UIApplication *)application;
+ (void)applicationWillEnterForeground:(UIApplication *)application;


#pragma mark - 如果需要使用 URL Scheme 或 通用链接相关功能，请实现以下方法
+ (void)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;
+ (void)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity;

#pragma mark - 如需使用远程推送相关功能，请实现以下方法
+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

#pragma mark - 如需使用本地推送通知功能，请实现以下方法
+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;


#pragma mark - deprecated (废弃API)
/// 运行目录中是否已经存在 App
/// @param appid appid
+ (BOOL)isExistsApp:(NSString *)appid __attribute__((deprecated("Use -isExistsUniMP:")));

/// 获取 App 运行路径，注：需要将应用资源放到此路径下
/// @param appid appid
+ (NSString *)getAppRunPathWithAppid:(NSString *)appid __attribute__((deprecated("Use -getUniMPRunPathWithAppid:")));

/// 将wgt应用资源包部署到运行路径中
/// @param appid appid
/// @param wgtPath wgt应用资源包路径
+ (BOOL)releaseAppResourceToRunPathWithAppid:(NSString *)appid
                            resourceFilePath:(NSString *)wgtPath __attribute__((deprecated("Use -installUniMPResourceWithAppid:resourceFilePath:password:error:")));

/// 启动 App
/// @param appid appid
/// @param arguments 启动参数（可以在小程序中通过 plus.runtime.arguments 获取此参数）
+ (void)openApp:(NSString *)appid
      arguments:(NSDictionary * __nullable)arguments __attribute__((deprecated("Use -openUniMP:configuration:completed:")));

/// 启动 App
/// @param appid appid
/// @param arguments 启动参数（可以在小程序中通过 plus.runtime.arguments 获取此参数）
/// @param redirectPath 启动后直接打开的页面路径 例："pages/component/view/view?a=1&b=2"
+ (void)openApp:(NSString *)appid
      arguments:(NSDictionary * _Nullable)arguments
   redirectPath:(NSString * _Nullable)redirectPath __attribute__((deprecated("Use -openUniMP:configuration:completed:")));

/// 设置导航栏上的胶囊按钮显示还是隐藏（默认显示）
/// @param menuButtonHidden Bool 是否隐藏胶囊按钮
+ (void)setMenuButtonHidden:(BOOL)menuButtonHidden __attribute__((deprecated("Use -setCapsuleButtonHidden:")));

/// 向小程序发送事件
/// @param event 事件名称
/// @param data 数据：NSString 或 NSDictionary 类型
+ (void)sendUniMPEvent:(NSString *)event data:(id)data __attribute__((deprecated("Use DCUniMPInstance -sendUniMPEvent:data:")));

@end

NS_ASSUME_NONNULL_END
