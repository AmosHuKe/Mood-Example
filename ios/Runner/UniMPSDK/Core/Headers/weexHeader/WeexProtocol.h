//
//  WeexProtocol.h
//  libPDRCore
//
//  Created by DCloud on 2018/6/7.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* kWeexImportClassName;
#import "WXSDKInstance.h"
#import "WXSDKManager.h"
#import "WXDefine.h"

@class WXRootView;

extern NSString* const kWeexOptionsRenderKey;
extern NSString* const kWeexOptionsFrameworkKey;

@protocol WeexProtocol <NSObject>
- (void)initWeexWithOptions:(NSDictionary*)options;
- (NSDictionary *)getWeexOptions;
- (void)destoryWeex;
- (id)newWXSDKInstance;
- (NSString*)getweexExposedModuleJs;
- (WXRootView*)weexInstanceRootView:(CGRect)frame;
- (WXBridgeManager*)bridgeMgr;
- (void)restart;
- (void)restartWithOptions:(NSDictionary*)options;
- (void)refreshDefaultFlexDirection;
- (BOOL)weexDebugMode;
- (void)evaljs:(NSString*)js inSDKInstance:(NSString*)instance;
- (void)postWeexMessageWithPayload:(NSDictionary*)payload inWeexInstance:(NSString*)instanceId;
- (id)callNativeModulSyncWithPayload:(NSDictionary*)payload inWeexInstance:(NSString*)instanceId;
@end
