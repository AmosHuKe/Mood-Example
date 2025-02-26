// dart format width=80
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'shared/config/dependencies.dart';
import 'application.dart';

void main() {
  runApp(
    MultiProvider(
      providers: Dependencies.providersLocal,
      child: const Application(),
    ),
  );
}
