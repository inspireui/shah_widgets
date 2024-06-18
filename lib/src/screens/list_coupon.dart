import 'package:flutter/material.dart';

import '../entities/coupon.dart';
import '../widgets/coupon_card/index.dart';

class CouponsScreen extends StatelessWidget {
  final String? header;
  final List<ShahCoupon> coupons;
  const CouponsScreen({
    super.key,
    required this.coupons,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          header ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 20,
            runSpacing: 30,
            children: List.generate(
              coupons.length,
              (index) {
                return CouponCard(
                  item: coupons[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
