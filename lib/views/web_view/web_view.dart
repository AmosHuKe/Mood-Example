import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/utils.dart';
import '../../themes/app_theme.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../widgets/animation/animation.dart';
import '../../widgets/action_button/action_button.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});

  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController pageWebViewController;
  String pageTitle = '';
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  void initState() {
    super.initState();
    initWebView();
  }

  void initWebView() {
    final url = ValueBase64(widget.url).decode();
    pageWebViewController = WebViewController()
      ..setJavaScriptMode(.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('加载中：$progress');
            if (!mounted) return;
            final appL10n = AppL10n.of(context);
            setState(() {
              pageTitle = '${appL10n.web_view_loading_text} ${progress - 1}%';
            });
          },
          onPageStarted: (String url) {
            print('开始加载：$url');
            if (!mounted) return;
            setState(() {
              pageTitle = url;
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
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.textTheme.displayLarge!.color,
        shadowColor: Colors.transparent,
        titleTextStyle: .new(color: theme.textTheme.bodyMedium!.color, fontSize: 14),
        title: Text(pageTitle),
        leading: ActionButton(
          key: const .new('widget_web_view_close'),
          semanticsLabel: '返回',
          decoration: BoxDecoration(
            color: isDark ? theme.cardColor : AppTheme.staticBackgroundColor1,
            borderRadius: const .only(bottomRight: .circular(18)),
          ),
          child: const Icon(Remix.close_fill, size: 24),
          onTap: () {
            context.pop();
          },
        ),
        actions: [
          AnimatedPress(
            child: IconButton(
              tooltip: '刷新',
              onPressed: () async {
                await pageWebViewController.reload();
              },
              icon: const Icon(Remix.refresh_line),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (_) {
          return canGoBack || canGoForward
              ? Row(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Builder(
                      builder: (_) {
                        return canGoBack
                            ? Expanded(
                                child: IconButton(
                                  onPressed: () async {
                                    await pageWebViewController.goBack();
                                  },
                                  icon: Icon(
                                    Remix.arrow_left_s_line,
                                    color: theme.textTheme.bodyMedium!.color,
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                    Builder(
                      builder: (_) {
                        return canGoForward
                            ? Expanded(
                                child: IconButton(
                                  onPressed: () async {
                                    await pageWebViewController.goForward();
                                  },
                                  icon: Icon(
                                    Remix.arrow_right_s_line,
                                    color: theme.textTheme.bodyMedium!.color,
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
      body: WebViewWidget(controller: pageWebViewController),
    );
  }

  /// 网页初始化
  Future<void> webViewInit() async {
    final pageTitleName = await pageWebViewController.getTitle() ?? '';
    final pageCanGoBack = await pageWebViewController.canGoBack();
    final pageCanGoForward = await pageWebViewController.canGoForward();
    setState(() {
      pageTitle = pageTitleName;
      canGoBack = pageCanGoBack;
      canGoForward = pageCanGoForward;
    });
  }
}
