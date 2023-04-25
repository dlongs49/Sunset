import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double value; // 进度值 0~1之间 使用 FractionallySizedBox 接收
  final Color backgroundColor; // 进度条的背景色 一般是白色底
  final valueColor; // 进度条的颜色值，可以自定义
  final double height; // 进度条的高度及承载的高度
  final double borderRadius; // 进度条的圆角，这里设置了右上角和右下角的圆角

  const CustomLinearProgressIndicator(
      {Key? key,
      required this.value,
      this.backgroundColor = Colors.white,
      this.valueColor, // 这里的颜色值 0xff 固定 ff应该代表透明度， 22da7e 为十进制的颜色值
      this.height = 3,
      this.borderRadius = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          color: backgroundColor,
        ),
        // 可以使用百分比控制宽度
        FractionallySizedBox(
          widthFactor: value,
          child: Container(
            height: height,
            decoration: BoxDecoration(
                color: Color(valueColor),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius))),
          ),
        )
      ],
    );
  }
}
