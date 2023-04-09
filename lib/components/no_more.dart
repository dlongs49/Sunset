import 'package:flutter/cupertino.dart';

class NoMore extends StatelessWidget {
  const NoMore({Key? key}) : super(key: key);
  // 暂无更多组件
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      child: Text("到底了~",style: TextStyle(color: Color(0xffc4c4c4),fontSize: 14)),
    );
  }
}
