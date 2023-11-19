import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:moodexample/common/utils.dart';
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';
import 'package:moodexample/widgets/animation/animation.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _pageWebViewController;
  String _pageTitle = '';
  bool _canGoBack = false;
  bool _canGoForward = false;

  @override
  void initState() {
    super.initState();

    final String url = ValueConvert(widget.url).decode();
    _pageWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('加载中：$progress');
            if (!mounted) return;
            setState(() {
              _pageTitle =
                  '${S.of(context).web_view_loading_text} ${progress - 1}%';
            });
          },
          onPageStarted: (String url) {
            print('开始加载：$url');
            if (!mounted) return;
            setState(() {
              _pageTitle = url;
            });
          },
          onPageFinished: (String url) {
            print('加载完成：$url');
            if (!mounted) return;
            webViewInit();
          },
          onWebResourceError: (WebResourceError error) {
            print('加载错误：$error');
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.displayLarge!.color,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color,
          fontSize: 14.sp,
        ),
        title: Text(_pageTitle),
        leading: ActionButton(
          key: const Key('widget_web_view_close'),
          semanticsLabel: '返回',
          decoration: BoxDecoration(
            color: isDarkMode(context)
                ? Theme.of(context).cardColor
                : AppTheme.backgroundColor1,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(18.w)),
          ),
          child: Icon(
            Remix.close_fill,
            size: 24.sp,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          AnimatedPress(
            child: IconButton(
              tooltip: '刷新',
              onPressed: () async {
                await _pageWebViewController.reload();
              },
              icon: const Icon(Remix.refresh_line),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (_) {
          return _canGoBack || _canGoForward
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Builder(
                      builder: (_) {
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
                                        .bodyMedium!
                                        .color,
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                    Builder(
                      builder: (_) {
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
                                        .bodyMedium!
                                        .color,
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                  ],
                )
              : const SizedBox();
        },
      ),
      body: WebViewWidget(controller: _pageWebViewController),
    );
  }

  /// 网页初始化
  void webViewInit() async {
    final String pageTitle = await _pageWebViewController.getTitle() ?? '';
    final bool pageCanGoBack = await _pageWebViewController.canGoBack();
    final bool pageCanGoForward = await _pageWebViewController.canGoForward();
    setState(() {
      _pageTitle = pageTitle;
      _canGoBack = pageCanGoBack;
      _canGoForward = pageCanGoForward;
    });
  }
}
