//
//  WXSDKInstance+DCExtend.h
//  libWeex
//
//  Created by XHY on 2019/2/18.
//  Copyright © 2019 DCloud. All rights reserved.
//

#import "WXSDKInstance.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXSDKInstance (DCExtend)


/**
 交换原方法，在options中添加一些自定义参数
 */
- (void)_dc_renderWithURL:(NSURL *)url options:(NSDictionary *)options data:(id)data;
- (void)_dc_renderView:(id)source options:(NSDictionary *)options data:(id)data;
@end

NS_ASSUME_NONNULL_END
