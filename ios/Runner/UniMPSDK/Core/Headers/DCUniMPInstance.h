//
//  DCUniMPInstance.h
//  DCUniMP
//
//  Created by XHY on 2020/1/14.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCUniMPConfiguration.h"

/// 方法执行回调block
/// @param success 是否执行成功
/// @param error 失败信息
typedef void(^DCUniMPResultBlock)(BOOL success, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface DCUniMPInstance : NSObject

@property (nonatomic, copy, readonly) NSString *appid; /**< 小程序的 appid */
@property (nonatomic, strong) DCUniMPConfiguration *configuration; /**< 小程序应用的配置信息 */

/// 将小程序显示到前台
/// @param completion 方法执行回调
- (void)showWithCompletion:(DCUniMPResultBlock)completion;

/// 将小程序隐藏到后台
/// @param completion 方法执行回调
- (void)hideWithCompletion:(DCUniMPResultBlock)completion;

/// 关闭小程序
/// @param completion 方法执行回调
- (void)closeWithCompletion:(DCUniMPResultBlock)completion;

/// 向小程序发送事件
/// @param event 事件名称
/// @param data 数据：NSString 或 NSDictionary 类型
- (void)sendUniMPEvent:(NSString *)event data:(id __nullable)data;

@end

NS_ASSUME_NONNULL_END
