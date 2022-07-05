//
//  DCUniMPMenuActionSheetStyle.h
//  libPDRCore
//
//  Created by XHY on 2020/2/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCUniMPCapsuleButtonStyle : NSObject
/// 胶囊按钮背景颜色 支持："#RRGGBB" 和 "rgba(R,G,B,A)" 格式字符串
@property (nonatomic, copy) NSString *backgroundColor;
/// 胶囊按钮 “···｜x” 的字体颜色 支持："#RRGGBB" 和 "rgba(R,G,B,A)" 格式字符串
@property (nonatomic, copy) NSString *textColor;
/// 胶囊按钮按下状态背景颜色 支持："#RRGGBB" 和 "rgba(R,G,B,A)" 格式字符串
@property (nonatomic, copy) NSString *highlightColor;
/// 胶囊按钮边框颜色 支持："#RRGGBB" 和 "rgba(R,G,B,A)" 格式字符串
@property (nonatomic, copy) NSString *borderColor;

@end

@interface DCUniMPMenuActionSheetStyle : NSObject

/// ActionSheet 按钮字体颜色 支持："#RRGGBB" 和 "rgba(R,G,B,A)" 格式字符串。默认值黑色
@property (nonatomic, copy) NSString *textColor;

/// ActionSheet 按钮文字大小 。默认值 16
@property (nonatomic, assign) CGFloat fontSize;

/// ActionSheet 按钮文字的粗细 可取值："normal" - 标准字体； "bold" - 加粗字体。 默认值为"normal"。
@property (nonatomic, copy) NSString *fontWeight;

@end


@interface DCUniMPMenuActionSheetItem : NSObject

/// 标题
@property (nonatomic, copy) NSString *title;

/// item 标识（当点击 ActionSheet 对应的 item 返回此标识）
@property (nonatomic, copy) NSString *identifier;


/// 实例化方法
/// @param title 标题
/// @param identifier 标识
- (instancetype)initWithTitle:(NSString *)title identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
