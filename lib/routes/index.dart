import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
/* 内嵌H5 */
import 'package:sunset/pages/webview/mall.dart'; // 我的-->香豆商城[淘宝]
import 'package:sunset/pages/webview/invite.dart'; // 我的-->邀请[空]
import 'package:sunset/pages/webview/shopdetail.dart'; // 发现商品详情

/* 页面 */
import 'package:sunset/app.dart';
import 'package:sunset/pages/my/my_device.dart'; // 我的-->我的设备
import 'package:sunset/pages/device/bind_device.dart'; // 我的-->设备绑定
import 'package:sunset/pages/device/balance.dart'; // 我的-->体脂秤
import 'package:sunset/pages/my/theme_skin.dart'; // 我的-->主题换肤
import 'package:sunset/pages/my/family.dart'; // 我的-->家庭成员
import 'package:sunset/pages/my/setting.dart'; // 我的-->设置
import 'package:sunset/pages/my/myinfo.dart'; // 我的--> 个人信息
import 'package:sunset/pages/my/my_profile.dart'; // 我的-->个人简介
import 'package:sunset/pages/my/scan.dart'; // 我的-->扫一扫
import 'package:sunset/pages/my/set_accnum.dart'; //设置--> 账号设置
import 'package:sunset/pages/detail/user_info.dart'; // 用户信息 & 发布者信息
import 'package:sunset/pages/detail/dynamic_detail.dart'; // 动态详情

import 'package:sunset/pages/sign/dsy_accnum.dart'; // 注销账号
import 'package:sunset/pages/sign/forget_pwd.dart'; // 忘记密码
import 'package:sunset/pages/sign/phone_log.dart'; // 手机登录
import 'package:sunset/pages/sign/pwd_log.dart'; // 密码登录
import 'package:sunset/pages/sign/set_pwd.dart'; // 设置密码 & 重置密码

final Map<String, WidgetBuilder> routes = {
  //"/":(BuildContext context) => App(), // 说明：这里如果指定了页面那么在 main中 home: HomePage() 不能存在
  "myDevice": (BuildContext context) => MyDevice(),
  "bindDevice": (BuildContext context) => BindDevice(),
  "balance": (BuildContext context) => Balance(),
  "themeSkin": (BuildContext context) => ThemeSkin(),
  "family": (BuildContext context) => Family(),
  "setting": (BuildContext context) => Setting(),
  "myInfo": (BuildContext context) => MyInfo(),
  "myProfile": (BuildContext context) => MyProfile(),
  "mall": (BuildContext context) => Mall(),
  "invite": (BuildContext context) => Invite(),
  "scan": (BuildContext context) => Scan(),
  "userInfo": (BuildContext context) => UserInfo(),
  "setAccnum": (BuildContext context) => SetAccnum(),
  "dynamicDetail":(BuildContext context)=>DynamicDetail(),
  "shopDetail":(BuildContext context)=> ShopDetail(),
  "dsyAccnum":(BuildContext context)=> DsyAccnum(),
  "forgetPwd":(BuildContext context)=> ForgetPwd(),//forgetPwd
  "phoneLog":(BuildContext context)=> PhoneLogin(),//phoneLog
  "pwdLogin":(BuildContext context)=> PwdLogin(), // pwdLogin
  "/":(BuildContext context)=> SetPwd(),//setPwd
};

// 路由处理
// ignore: top_level_function_literal_block
var onGenerateRoute=(RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context));
      return route;
    }
  }
};