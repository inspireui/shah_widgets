import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shah_widgets/shah_widgets.dart';
import 'package:shah_widgets/src/services/coupon_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../extensions/color_ext.dart';
import '../entities/coupon.dart';
import '../screens/list_coupon.dart';
import 'coupon_card/index.dart';

class ShahCouponSlider extends StatefulWidget {
  final Map config;
  const ShahCouponSlider({
    required this.config,
    super.key,
  });

  @override
  StateShahCouponSlider createState() => StateShahCouponSlider();
}

class StateShahCouponSlider extends State<ShahCouponSlider> {
  List<ShahCoupon>? coupons;
  PageController? _controller;
  String? get headerText => widget.config['name'] ?? '';
  int get interval => int.tryParse('${widget.config['interval']}') ?? 3;
  bool get isAutoPlay => bool.tryParse('${widget.config['autoPlay']}') ?? true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    WidgetsBinding.instance.endOfFrame.then((_) async {
      if (mounted) {
        coupons = await CouponService.getShahCoupons();
        if (isAutoPlay) {
          autoPlay();
        }
        setState(() {});
      }
    });
  }

  void autoPlay() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: interval), (callback) {
      final position = _controller?.page?.toInt() ?? 0;
      var length = coupons?.length ?? 0;
      if (length > 8) {
        length = 8;
      }
      if (length < 2) {
        return;
      }
      if (position < length - 1) {
        _controller?.animateToPage(
          position + 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        _controller?.jumpToPage(0);
      }
    });
  }

  void onTapSeeAll() {
    if (coupons?.isEmpty ?? true) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CouponsScreen(
          header: headerText,
          coupons: coupons ?? [],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ShahCouponSlider oldWidget) {
    if (isAutoPlay && timer == null) {
      autoPlay();
    }
    if (!isAutoPlay && timer != null) {
      timer?.cancel();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var length = coupons?.length ?? 3;
    if (length > 8) {
      length = 8;
    }
    return Column(
      children: [
        ShahWidgets.component.headerView(
          headerText: headerText,
          callback: onTapSeeAll,
        ),
        SizedBox(
          height: 210,
          child: PageView(
            controller: _controller,
            children: List.generate(length, (index) {
              var item = coupons?[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CouponCard(
                  item: item,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 7),
        if (length > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SmoothPageIndicator(
              controller: _controller ?? PageController(),
              count: length,
              effect: SlideEffect(
                spacing: 8.0,
                radius: 5.0,
                dotWidth: 6.0,
                dotHeight: 6.0,
                paintStyle: PaintingStyle.fill,
                strokeWidth: 1.5,
                dotColor: HexColor.fromHEX('#8c52ff').withOpacity(0.2),
                activeDotColor: HexColor.fromHEX('#8c52ff'),
              ),
            ),
          ),
      ],
    );
  }
}
