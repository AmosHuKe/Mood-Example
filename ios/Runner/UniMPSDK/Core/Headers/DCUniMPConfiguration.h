//
//  DCUniMPConfiguration.h
//  libPDRCore
//
//  Created by XHY on 2020/6/16.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 打开小程序页面的方式
typedef NS_ENUM(NSUInteger,DCUniMPOpenMode) {
    /// 获取宿主当前显示的 ViewController 调用 presentViewController:animated:completion: 方法打开小程序页面对应的 DCUniMPViewController
    DCUniMPOpenModePresent,
    /// 获取宿主当前显示的 ViewController 对应的 navigationController 调用 pushViewController:animated: 方法打开小程序页面对应的 DCUniMPViewController，注意：如果 navigationController 不存在则使用 DCUniMPOpenModePresent 的方式打开
    DCUniMPOpenModePush
};

@interface DCUniMPConfiguration : NSObject

@property (nonatomic, strong, nullable) id extraData; /**< 需要传递给目标小程序的数据 默认：nil 支持 NSString 或 NSDictionary 类型*/
@property (nonatomic, copy, nullable) NSString *fromAppid; /**< 小程序打开小程序时传来源小程序的appid */
@property (nonatomic, copy, nullable) NSString *path;  /**< 打开的页面路径，如果为空则打开首页。path 中 ? 后面的部分会成为 query 例："pages/component/view/view?a=1&b=2" 默认：nil*/
@property (nonatomic, assign) NSInteger scene; /**< 启动小程序的场景值 需要宿主自定义 */
@property (nonatomic, assign) BOOL enableBackground;    /**< 是否开启后台运行（退出小程序时隐藏到后台不销毁小程序应用） 默认：NO*/
@property (nonatomic, assign) BOOL showAnimated;    /**< 是否开启 show 小程序时的动画效果 默认：YES */
@property (nonatomic, assign) BOOL hideAnimated;    /**< 是否开启 hide 时的动画效果 默认：YES*/
@property (nonatomic, assign) DCUniMPOpenMode openMode;  /**< 打开小程序的方式 默认： DCUniMPOpenModePresent*/
@property(nonatomic, assign) BOOL enableGestureClose;   /**< 是否开启手势关闭小程序 默认：NO */


@property (nonatomic, strong, nullable) NSDictionary *arguments __attribute__((deprecated("即将废弃，使用 extraData 代替")));
@property (nonatomic, copy, nullable) NSString *redirectPath __attribute__((deprecated("即将废弃，使用 path 代替")));

@end

NS_ASSUME_NONNULL_END
