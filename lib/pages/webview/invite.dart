import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';

class Invite extends StatefulWidget {
  const Invite({Key? key}) : super(key: key);

  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Column(
        children: [
          CustomTabBar(title: "邀请好友", bgColor: null, fontColor: null),
          Expanded(child: Align(child: Image.asset("assets/images/none.png"))),
        ],
      )
    );
  }
}
