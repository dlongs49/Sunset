import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunset/components/tabbar.dart';

class MyFollow extends StatefulWidget {
  const MyFollow({Key? key}) : super(key: key);

  @override
  _MyFollowState createState() => _MyFollowState();
}

class _MyFollowState extends State<MyFollow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          CustomTabBar(title: "我的关注", bgColor: null, fontColor: null),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.5,color: Color(0xfff6f6f6)))
                  ),
                  child: Row(children: [
                    InkWell(
                        child: Container(
                            width: 38,
                            height: 38,
                            margin: EdgeInsets.only(right: 8),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(38),
                                child: Image.network(
                                    "https://th.bing.com/th/id/OIP.g9UbVfyVZX-SfD09JcYr5QHaEK?pid=ImgDet&rs=1",
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, stackTrace) =>
                                        Image.asset('assets/images/sunset.png',
                                            //默认显示图片
                                            height: 38,
                                            width: double.infinity)))),
                        onTap: () => {}),
                    Container(
                      child: Text("书本书华",style: TextStyle(color: Color(0xff666666),fontSize: 15)),

                    )
                  ]),
                );
              },
            ),
          )
        ]));
  }
}
