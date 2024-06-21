import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shah_widgets/src/entities/product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/color_ext.dart';

class ProductCouponCardWidget extends StatelessWidget {
  final ShahProduct product;
  const ProductCouponCardWidget(this.product, {super.key});

  void onTap() async {
    if (product.code?.isNotEmpty ?? false) {
      await Clipboard.setData(ClipboardData(text: '${product.code}'));
    }
    final url = product.externalUrl;
    if (url?.isNotEmpty ?? false) {
      launchUrl(Uri.parse('$url'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        children: [
          if (product.externalUrl?.isNotEmpty ?? false)
            InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Row(
                    children: [
                      const Center(
                        child: Icon(
                          CupertinoIcons.tickets,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'انسخ و تسوق',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 4),
                      const Center(
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(width: 10),
          SizedBox(
            width: 70,
            child: (product.code?.isEmpty ?? false)
                ? const SizedBox()
                : Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: HexColor.fromHEX('#0d6efd'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${product.code}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
