import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../entities/coupon.dart';
import '../../extensions/color_ext.dart';
import '../../extensions/locale_ext.dart';
import '../../screens/coupon_detail/coupon_detail.dart';
import '../skeleton.dart';
import 'painter.dart';

class CouponCard extends StatelessWidget {
  final ShahCoupon? item;
  const CouponCard({super.key, this.item});

  void onTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CouponDetail(
        item: item,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = item?.image;
    if (item == null) {
      return const Skeleton(
        height: 210,
        cornerRadius: 10,
      );
    }
    return GestureDetector(
      onTap: () => onTap(context),
      child: CustomPaint(
        painter: CouponPainter(
          color: Theme.of(context).dividerColor,
          strokeWidth: 2,
          isRTL: context.isRTL,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 210,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: (image?.isNotEmpty ?? false)
                              ? Image.network('$image')
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          '${item?.title}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'متبقي ${item?.dayUntilEnd} أيام',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.checkmark_alt,
                            size: 16,
                            color: HexColor.fromHEX('#4de66d'),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            'أخر استخدام من ${item?.lastDateCopy}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 50),
              Container(
                width: 100,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor.fromHEX('#4de66d'),
                      ),
                      child: Center(
                        child: Text(
                          'خصم',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${item?.discountPercentage}%',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: HexColor.fromHEX('#8c52ff'),
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor.fromHEX('#0d6efd'),
                      ),
                      child: Center(
                        child: Text(
                          'نسخ',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
