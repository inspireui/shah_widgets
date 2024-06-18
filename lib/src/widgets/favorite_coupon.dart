import 'package:flutter/cupertino.dart';
import 'package:shah_widgets/shah_widgets.dart';
import 'package:shah_widgets/src/routes/route.dart';

class FavoriteCoupon extends StatelessWidget {
  final String? style;
  const FavoriteCoupon({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final cookie = ShahWidgets.component.cookie(context);
    if (cookie?.isEmpty ?? true) {
      return const SizedBox();
    }
    return ShahWidgets.component.settingItemWidget(
      icon: CupertinoIcons.star,
      title: 'Favorite Coupons',
      onTap: () => Navigator.pushNamed(context, RouteList.favoriteCoupon),
      style: style,
    );
  }
}
