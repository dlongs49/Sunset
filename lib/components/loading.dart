import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_loading/m_loading.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 6,bottom: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 15,
              height: 15,
              color: Colors.white24,
              child: BallCircleOpacityLoading(
                ballStyle: BallStyle(
                    size: 2,
                    color: Color(0xffc4c4c4),
                    ballType: BallType.solid,
                    borderWidth: 4),
              ),
            ),
            SizedBox(width: 8),
            Text(
              "加载中...",
              style: TextStyle(
                  color: Color(0xffc4c4c4), fontSize: 13),
            )
          ]),
    );
  }
}
