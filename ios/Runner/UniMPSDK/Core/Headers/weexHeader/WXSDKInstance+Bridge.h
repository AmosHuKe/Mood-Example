//
//  WXSDKInstance+Bridge.h
//  libWeex
//
//  Created by dcloud on 2019/3/4.
//  Copyright © 2019 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXSDKInstance.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, WXSDKInstanceBridgeEvent) {
    WXSDKInstanceBridgeEventExec,
    WXSDKInstanceBridgeEventExecSync,
    WXSDKInstanceBridgeEventUniappFrameworkReady,
    WXSDKInstanceBridgeEventPostMessage,
    WXSDKInstanceBridgeEventGeInfo
};

@interface WXSDKInstance(DCPlusBridge)
@property (nonatomic, copy) id __nullable (^onMessage)(WXSDKInstanceBridgeEvent evt, id __nullable param);
- (void)postMessage:(NSDictionary*)message;
- (void)exec:(NSString*)message;
- (NSData*)execSync:(NSString*)message;
- (void)onUniappFramworkReady:(NSString*)message;
- (NSDictionary*)getConfigInfo;
- (void)dc_executeJavascript:(NSString*)javaScriptString;
- (void)clearOnMessage;
@end

NS_ASSUME_NONNULL_END
