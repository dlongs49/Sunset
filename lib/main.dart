import 'dart:ui';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunset/provider/global.dart';
import 'package:sunset/routes/index.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({}); // 缓存
  runApp(
      // MyApp()
      ListenableProvider<Golbal>(create: (_) => Golbal(), child: MyApp()));
  //透明沉浸式状态栏
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Sunset',
      builder: BotToastInit(),
      // BotToast全局注册
      navigatorObservers: [BotToastNavigatorObserver()],
      // BotToast全局注册
      localizationsDelegates: [
        // 语言代理
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'), //设置语言为中文
      ],
      // 开放环境下移除右上角 debug 标志
      debugShowCheckedModeBanner: false,

      /*
        这里的 home 与 initialRoute 只能存其一
        home: HomePage(),
      */
      // 初始化路由 >> 说明：这里如果指定了页面那么在 routes 文件中 不能含有 '/'
      initialRoute: "/",
      // 命名路由
      onGenerateRoute: onGenerateRoute,
      /*
      基本路由，推荐命名路由
      routes:{
          "my":(context)=>My(),
          ...
       } */
    );
  }
}
