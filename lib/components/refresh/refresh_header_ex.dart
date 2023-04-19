import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 继承 easy_refresh源码修改下拉刷新文字
class RefreshHeaderEx extends ClassicHeader{
  final Key? key;

  /// The location of the widget.
  /// Only supports [MainAxisAlignment.center],
  /// [MainAxisAlignment.start] and [MainAxisAlignment.end].
  final MainAxisAlignment mainAxisAlignment;

  /// Background color.
  final Color? backgroundColor;

  /// Text on [IndicatorMode.drag].
  final String? dragText;

  /// Text on [IndicatorMode.armed].
  final String? armedText;

  /// Text on [IndicatorMode.ready].
  final String? readyText;

  /// Text on [IndicatorMode.processing].
  final String? processingText;

  /// Text on [IndicatorMode.processed].
  final String? processedText;

  /// Text on [IndicatorResult.noMore].
  final String? noMoreText;

  /// Text on [IndicatorResult.fail].
  final String? failedText;

  /// Whether to display text.
  final bool showText;

  /// Message text.
  /// %T will be replaced with the last time.
  final String? messageText;

  /// Whether to display message.
  final bool showMessage;

  /// The dimension of the text area.
  /// When less than 0, calculate the length of the text widget.
  final double? textDimension;

  /// The dimension of the icon area.
  final double iconDimension;

  /// Spacing between text and icon.
  final double spacing;

  /// Icon when [IndicatorResult.success].
  final Widget? succeededIcon;

  /// Icon when [IndicatorResult.fail].
  final Widget? failedIcon;

  /// Icon when [IndicatorResult.noMore].
  final Widget? noMoreIcon;

  /// Icon on pull.
  final CIPullIconBuilder? pullIconBuilder;

  /// Text style.
  final TextStyle? textStyle;

  /// Build text.
  final CITextBuilder? textBuilder;

  /// Text style.
  final TextStyle? messageStyle;

  /// Build message.
  final CIMessageBuilder? messageBuilder;

  /// Link [Stack.clipBehavior].
  final Clip clipBehavior;

  /// Icon style.
  final IconThemeData? iconTheme;

  /// Progress indicator size.
  final double? progressIndicatorSize;

  /// Progress indicator stroke width.
  /// See [CircularProgressIndicator.strokeWidth].
  final double? progressIndicatorStrokeWidth;

  RefreshHeaderEx({
    this.key,
    double triggerOffset = 60,
    bool clamping = false,
    IndicatorPosition position = IndicatorPosition.above,
    Duration processedDuration = const Duration(seconds: 1),
    SpringBuilder? readySpringBuilder,
    bool springRebound = true,
    FrictionFactor? frictionFactor,
    bool safeArea = true,
    double? infiniteOffset,
    bool? hitOver,
    bool? infiniteHitOver,
    bool hapticFeedback = false,
    bool triggerWhenReach = false,
    bool triggerWhenRelease = false,
    double maxOverOffset = double.infinity,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.backgroundColor,
    this.dragText:"下拉刷新",
    this.armedText:"释放以刷新",
    this.readyText:"刷新中...",
    this.processingText:"加载中...",
    this.processedText:"刷新成功",
    this.noMoreText:"暂无更多",
    this.failedText:"加载失败",
    this.showText = true,
    this.messageText:"上次刷新时间 %T",
    this.showMessage = true,
    this.textDimension,
    this.iconDimension = 20,
    this.spacing = 16,
    this.succeededIcon,
    this.failedIcon,
    this.noMoreIcon,
    this.pullIconBuilder,
    this.textStyle:const TextStyle(fontWeight: FontWeight.w600,color: Color(0xff666666)), // 重写文字样式
    this.textBuilder,
    this.messageStyle:const TextStyle(fontWeight: FontWeight.w600,color: Color(0xff666666)),// 重写文字样式
    this.messageBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.iconTheme,
    this.progressIndicatorSize,
    this.progressIndicatorStrokeWidth:2.0,
  }) : super(
    triggerOffset: triggerOffset,
    clamping: clamping,
    processedDuration: processedDuration,
    readySpringBuilder: readySpringBuilder,
    springRebound: springRebound,
    frictionFactor: frictionFactor,
    safeArea: safeArea,
    infiniteOffset: infiniteOffset,
    hitOver: hitOver,
    infiniteHitOver: infiniteHitOver,
    position: position,
    hapticFeedback: hapticFeedback,
    triggerWhenReach: triggerWhenReach,
    triggerWhenRelease: triggerWhenRelease,
    maxOverOffset: maxOverOffset,
  );
}