class ShahProduct {
  String? code;
  String? externalUrl;

  ShahProduct.fromJson(dynamic json) {
    code = json['coupon_code'];
    externalUrl = json['external_url'];
  }

  Map toJson() {
    var map = {
      'coupon_code': code,
      'external_url': externalUrl,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
