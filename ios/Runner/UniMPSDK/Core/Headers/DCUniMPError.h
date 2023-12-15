//
//  DCUniMPError.h
//  libPDRCore
//
//  Created by XHY on 2020/6/15.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const DCUniMPErrorDomain = @"DCUniMPErrorDomain";

typedef NS_ENUM(NSInteger,DCUniMPErrorCode) {
    /// 未知错误
    DCUniMPErrorUnknown = -999,
    /// 无效的参数
    DCUniMPErrorInvalidArgument = -1,
    /// 无权限
    DCUniMPErrorNotPermission = -2,
    /// 宿主未监听消息
    DCUniMPErrorHostNotListen = -3,
    /// 应用资源不存在
    DCUniMPErrorUniMPResourcesDoesNotExist = -1001,
    /// 非v3编译模式
    DCUniMPErrorNotCompiledByV3Mode = -1002,
    /// 应用资源安装（解压）失败
    DCUniMPErrorUniMPResourcesInstallError = -1003,
    /// 重复调用
    DCUniMPErrorRepeatedBehavior = -2001,
    /// 小程序未运行
    DCUniMPErrorUniMPNotRunning = -3001,
    /// 已存在运行的小程序
    DCUniMPErrorExistOtherUniMPRunning = -3002,
    /// 打开小程序的数量已达到上限
    DCUniMPErrorAppCountLimit = -3003,
    /// 已经存在打开的相同的小程序
    DCUniMPErrorExistSameUniMPRunning = - 3004
};
NS_ASSUME_NONNULL_END
