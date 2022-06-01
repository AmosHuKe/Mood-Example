import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:remixicon/remixicon.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
import 'package:moodexample/common/utils.dart';
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _pageWebViewController;
  String _pageTitle = '';
  bool _canGoBack = false;
  bool _canGoForward = false;

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    final String url = ValueConvert(widget.url).decode();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.headline1!.color,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.headline1!.color,
          fontSize: 14.sp,
        ),
        title: Text(_pageTitle),
        leading: ActionButton(
          key: const Key("widget_web_view_close"),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode(context)
                    ? [Theme.of(context).cardColor, Theme.of(context).cardColor]
                    : [AppTheme.backgroundColor1, AppTheme.backgroundColor1],
              ),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(18.w))),
          child: Icon(
            Remix.close_fill,
            size: 24.sp,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _pageWebViewController.reload();
            },
            icon: const Icon(Remix.refresh_line),
          )
        ],
      ),
      bottomNavigationBar: Builder(builder: (_) {
        return _canGoBack || _canGoForward
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(builder: (_) {
                    return _canGoBack
                        ? Expanded(
                            child: IconButton(
                              onPressed: () async {
                                await _pageWebViewController.goBack();
                              },
                              icon: Icon(
                                Remix.arrow_left_s_line,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                          )
                        : const SizedBox();
                  }),
                  Builder(builder: (_) {
                    return _canGoForward
                        ? Expanded(
                            child: IconButton(
                              onPressed: () async {
                                await _pageWebViewController.goForward();
                              },
                              icon: Icon(
                                Remix.arrow_right_s_line,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                          )
                        : const SizedBox();
                  }),
                ],
              )
            : const SizedBox();
      }),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        allowsInlineMediaPlayback: true,
        onWebViewCreated: (webViewController) async {
          _pageWebViewController = webViewController;
        },
        onPageStarted: (url) async {
          debugPrint("开始加载：$url");
          setState(() {
            _pageTitle = url;
          });
        },
        onProgress: (progress) async {
          debugPrint("加载中：$progress");
          setState(() {
            _pageTitle =
                "${S.of(context).web_view_loading_text} ${progress - 1}%";
          });
        },
        onPageFinished: (url) async {
          debugPrint("加载完成：$url");
          webViewInit();
        },
        onWebResourceError: (error) {
          debugPrint("加载错误：$error");
        },
      ),
    );
  }

  /// 网页初始化
  webViewInit() async {
    String pageTitle = await _pageWebViewController.getTitle() ?? '';
    bool pageCanGoBack = await _pageWebViewController.canGoBack();
    bool pageCanGoForward = await _pageWebViewController.canGoForward();
    setState(() {
      _pageTitle = pageTitle;
      _canGoBack = pageCanGoBack;
      _canGoForward = pageCanGoForward;
    });
  }
}
