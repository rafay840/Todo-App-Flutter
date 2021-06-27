import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/global/global.dart';
import 'package:todo_app/page/home_page.dart';
import 'package:todo_app/utils/keyboard_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  Global.init().then((value) => runApp(TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtils.hideKeyboard(context),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          RefreshLocalizations.delegate,
        ],
        navigatorKey: Global.navigatorKey,
        supportedLocales: S.delegate.supportedLocales,
        home: HomePage(),
      ),
    );
  }
}
