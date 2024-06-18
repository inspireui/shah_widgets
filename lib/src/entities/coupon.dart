/// customize for Shady agency

enum CouponAction {
  like,
  unlike,
  favorite,
  status,
}

class ShahCoupon {
  late String id;
  String? title;
  String? content;
  String? image;
  String? code;
  int? dayUntilEnd;
  String? lastDateCopy;
  int? discountPercentage;
  String? url;

  ShahCoupon.fromJson(dynamic json) {
    id = '${json['id']}';
    title = json['title']?['rendered'];
    content = json['coupon_content'] ?? json['content']?['rendered'];
    image = json['coupon_image'];
    code = json['coupon_code'];
    dayUntilEnd = int.tryParse('${json['coupon_days_until_end']}');
    lastDateCopy = json['coupon_last_date_copy'];
    discountPercentage = int.tryParse('${json['discount_percentage']}');
    url = json['coupon_url'];
  }
}