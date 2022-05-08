-dontwarn
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers
-dontpreverify
-verbose

#-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-dontoptimize

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends io.dcloud.common.DHInterface.IPlugin
-keep public class * extends io.dcloud.common.DHInterface.IFeature
-keep public class * extends io.dcloud.common.DHInterface.IBoot
-keep public class * extends io.dcloud.common.DHInterface.IReflectAble

-keep class io.dcloud.** {*;}
-dontwarn io.dcloud.**
-dontwarn com.alibaba.**

-keep class vi.com.gdi.** {*;}
-keep class android.support.v4.** {*;}

-keepclasseswithmembers class io.dcloud.appstream.StreamAppManager {
    public protected <methods>;
}

-keep public class * extends io.dcloud.common.DHInterface.IReflectAble{
  public protected <methods>;
  public protected *;
}
-keep class **.R
-keep class **.R$* {
    public static <fields>;
}
-keep public class * extends io.dcloud.common.DHInterface.IJsInterface{
  public protected <methods>;
  public protected *;
}

-keepclasseswithmembers class io.dcloud.EntryProxy {
    <methods>;
}

-keep class * implements android.os.IInterface {
  <methods>;
}

-keepclasseswithmembers class *{
  public static java.lang.String getJsContent();
}

-keepclasseswithmembers class *{
  public static io.dcloud.share.AbsWebviewClient getWebviewClient(io.dcloud.share.ShareAuthorizeView);
}

-keepattributes Exceptions,InnerClasses,Signature,Deprecated, SourceFile,LineNumberTable,*Annotation*,EnclosingMethod

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

-keep public class * extends android.app.Application{
  public static <methods>;
  public *;
}

-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
   public static <methods>;
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

-keep class dc.** {*;}
-keep class okio.**{*;}
-keep class org.apache.** {*;}
-keep class org.json.** {*;}
-keep class net.ossrs.** {*;}
-keep class android.** {*;}
-keep class com.facebook.**{*;}
-keep class com.bumptech.glide.**{*;}
-keep class com.alibaba.fastjson.**{*;}
-keep class com.sina.**{*;}
-keep class com.weibo.ssosdk.**{*;}
-keep class com.asus.**{*;}
-keep class com.bun.**{*;}
-keep class com.heytap.**{*;}
-keep class com.huawei.**{*;}
-keep class com.meizu.**{*;}
-keep class com.samsung.**{*;}
-keep class com.zui.**{*;}
-keep class com.amap.**{*;}
-keep class com.loc.**{*;}
-keep class com.autonavi.**{*;}
-keep class pl.droidsonroids.gif.**{*;}
-keep class com.tencent.**{*;}
-keep class com.baidu.**{*;}
-keep class com.iflytek.**{*;}
-keep class com.umeng.**{*;}
-keep class tv.**{*;}
-keep class master.**{*;}
-keep class uk.co.**{*;}
-keep class com.dmcbig.**{*;}
-dontwarn android.**
-dontwarn com.tencent.**

-keep class * implements com.taobao.weex.IWXObject{*;}
-keep public class * extends com.taobao.weex.common.WXModule{*;}


-keepattributes Signature

-dontwarn org.codehaus.mojo.**
-dontwarn org.apache.commons.**
-dontwarn com.amap.**
-dontwarn com.sina.weibo.sdk.**
-dontwarn com.alipay.**
-dontwarn com.lucan.ajtools.**
-dontwarn pl.droidsonroids.gif.**

-keep class com.taobao.weex.** { *; }
-keep class com.taobao.gcanvas.**{*;}
-dontwarn com.taobao.weex.**
-dontwarn com.taobao.gcanvas.**

#个推
-dontwarn com.igexin.**
-keep class com.igexin.** { *; }
-keep class org.json.** { *; }

-keep class android.support.v4.app.NotificationCompat { *; }
-keep class android.support.v4.app.NotificationCompat$Builder { *; }
#魅族
-keep class com.meizu.** { *; }
-dontwarn com.meizu.**
#小米
-keep class com.xiaomi.** { *; }
-dontwarn com.xiaomi.push.**
-keep class org.apache.thrift.** { *; }
#华为
-dontwarn com.huawei.hms.**
-keep class com.huawei.hms.** { *; }

-keep class com.huawei.android.** { *; }
-dontwarn com.huawei.android.**

-keep class com.hianalytics.android.** { *; }
-dontwarn com.hianalytics.android.**

-keep class com.huawei.updatesdk.** { *; }
-dontwarn com.huawei.updatesdk.**
#OPPO
-keep class com.coloros.mcssdk.** { *; }
-dontwarn com.coloros.mcssdk.**


#高德定位
-keep class com.amap.api.location.**{*;}
-keep class com.amap.api.fence.**{*;}
-keep class com.loc.**{*;}

#腾讯X5--------------start-----------------------
-dontwarn dalvik.**
-dontwarn com.tencent.smtt.**
#-overloadaggressively
# ------------------ Keep LineNumbers and properties ---------------- #
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
# --------------------------------------------------------------------------
# Addidional for x5.sdk classes for apps
-keep class com.tencent.smtt.export.external.**{*;}
-keep class com.tencent.tbs.video.interfaces.IUserStateChangedListener {*;}
-keep class com.tencent.smtt.sdk.CacheManager {public *;}
-keep class com.tencent.smtt.sdk.CookieManager {public *;}
-keep class com.tencent.smtt.sdk.WebHistoryItem {public *;}
-keep class com.tencent.smtt.sdk.WebViewDatabase {public *;}
-keep class com.tencent.smtt.sdk.WebBackForwardList {public *;}
-keep public class com.tencent.smtt.sdk.WebView {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebView$HitTestResult {public static final <fields>;public java.lang.String getExtra();public int getType();}
-keep public class com.tencent.smtt.sdk.WebView$WebViewTransport {public <methods>;}
-keep public class com.tencent.smtt.sdk.WebView$PictureListener {public <fields>;public <methods>;}
-keepattributes InnerClasses
-keep public enum com.tencent.smtt.sdk.WebSettings$** {*;}
-keep public enum com.tencent.smtt.sdk.QbSdk$** {*;}
-keep public class com.tencent.smtt.sdk.WebSettings {public *;}

-keepattributes Signature
-keep public class com.tencent.smtt.sdk.ValueCallback {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebViewClient {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.DownloadListener {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebChromeClient {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebChromeClient$FileChooserParams {public <fields>;public <methods>;}
-keep class com.tencent.smtt.sdk.SystemWebChromeClient{public *;}
# 1. extension interfaces should be apparent
-keep public class com.tencent.smtt.export.external.extension.interfaces.* {public protected *;}

# 2. interfaces should be apparent
-keep public class com.tencent.smtt.export.external.interfaces.* {public protected *;}
-keep public class com.tencent.smtt.sdk.WebViewCallbackClient {public protected *;}
-keep public class com.tencent.smtt.sdk.WebStorage$QuotaUpdater {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebIconDatabase {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.WebStorage {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.DownloadListener {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.QbSdk {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.QbSdk$PreInitCallback {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.CookieSyncManager {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.Tbs* {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.LogFileUtils {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.TbsLog {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.TbsLogClient {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.CookieSyncManager {public <fields>;public <methods>;}
# Added for game demos
-keep public class com.tencent.smtt.sdk.TBSGamePlayer {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGamePlayerClient* {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGamePlayerClientExtension {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGamePlayerService* {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.utils.Apn {public <fields>;public <methods>;}
-keep class com.tencent.smtt.** {*;}
# end
-keep public class com.tencent.smtt.export.external.extension.proxy.ProxyWebViewClientExtension {public <fields>;public <methods>;}
-keep class MTT.ThirdAppInfoNew {*;}
-keep class com.tencent.mtt.MttTraceEvent {*;}
# Game related
-keep public class com.tencent.smtt.gamesdk.* {public protected *;}
-keep public class com.tencent.smtt.sdk.TBSGameBooter {public <fields>;public <methods>;}
-keep public class com.tencent.smtt.sdk.TBSGameBaseActivity {public protected *;}
-keep public class com.tencent.smtt.sdk.TBSGameBaseActivityProxy {public protected *;}
-keep public class com.tencent.smtt.gamesdk.internal.TBSGameServiceClient {public *;}
#腾讯X5--------------end-----------------------