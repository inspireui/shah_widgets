import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:shah_widgets/shah_widgets.dart';
import 'package:shah_widgets/src/screens/list_coupon.dart';
import 'package:shah_widgets/src/services/coupon_service.dart';

import '../entities/coupon.dart';

class ListFavoriteCoupons extends StatefulWidget {
  const ListFavoriteCoupons({super.key});

  @override
  StateListFavoriteCoupons createState() => StateListFavoriteCoupons();
}

class StateListFavoriteCoupons extends State<ListFavoriteCoupons> {
  List<ShahCoupon>? coupons;
  String? get cookie => ShahWidgets.component.cookie(context);
  CancelableCompleter? completer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      getCoupons();
    });
  }

  void getCoupons() async {
    if (cookie == null) {
      return null;
    }
    await completer?.operation.cancel();
    completer = CancelableCompleter();
    completer?.complete(CouponService.getFavoriteShahCoupons('$cookie'));
    coupons = await completer?.operation.valueOrCancellation();
    if (completer?.isCanceled ?? false) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    completer?.operation.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CouponsScreen(
      header: 'Favorite Coupons',
      coupons: coupons ?? [],
    );
  }
}
