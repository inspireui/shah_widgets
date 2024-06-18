library shah_widgets;

import 'package:flutter/material.dart';
import 'src/routes/route.dart';
import 'src/screens/list_favorite_coupon.dart';
import 'src/widgets/coupon_slider.dart';
import 'src/widgets/favorite_coupon.dart';

class ShahWidgets {
  static ShahComponent? _component;
  static ShahComponent get component =>
      ShahWidgets._component ?? ShahComponentEmpty();

  static void init(ShahComponent value) {
    _component = value;
  }

  static Widget? dynamicLayout(Map config) {
    switch (config['layout']) {
      case 'shah_coupon':
        return component.cookieSelectorBuilder(builder: (context, cookie) {
          final required = bool.tryParse('${config['requiredLogin']}');
          if (required == true && (cookie?.isEmpty ?? true)) {
            return const SizedBox();
          }
          return ShahCouponSlider(config: config);
        });
      default:
    }
    return null;
  }

  static Widget? settingItemWidget(String type, {String? style}) {
    switch (type) {
      case 'favorite_coupon':
        return FavoriteCoupon(style: style);
      default:
    }
    return null;
  }

  static Map<String, WidgetBuilder> routes() {
    return {
      RouteList.favoriteCoupon: (_) => const ListFavoriteCoupons(),
    };
  }
}

abstract class ShahComponent {
  String get domain;
  String? cookie(BuildContext context);
  ShahTranslation trans = ShahTranslation();
  Widget headerView({
    String? headerText,
    VoidCallback? callback,
  });
  Widget settingItemWidget({
    IconData? icon,
    String? title,
    Widget? trailing,
    Function()? onTap,
    String? style,
  });
  Widget cookieSelectorBuilder({
    required Widget Function(BuildContext context, String? cookie) builder,
  });
}

class ShahComponentEmpty extends ShahComponent {
  @override
  String? cookie(BuildContext context) {
    return null;
  }

  @override
  String get domain => '';

  @override
  Widget headerView({String? headerText, VoidCallback? callback}) =>
      const SizedBox();

  @override
  Widget settingItemWidget({
    IconData? icon,
    String? title,
    Widget? trailing,
    Function()? onTap,
    String? style,
  }) =>
      const SizedBox();

  @override
  Widget cookieSelectorBuilder({
    required Widget Function(BuildContext context, String? cookie) builder,
  }) =>
      const SizedBox();
}

class ShahTranslation {
  String ok(BuildContext context) => 'ok';
}
