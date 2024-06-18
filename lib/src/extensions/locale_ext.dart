import 'package:flutter/material.dart';

extension LocaleExt on BuildContext {

  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}